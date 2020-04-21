package ndtp.domain;

import lombok.extern.slf4j.Slf4j;
import org.geotools.data.*;
import org.geotools.data.shapefile.ShapefileDataStore;
import org.geotools.data.simple.SimpleFeatureSource;
import org.geotools.data.simple.SimpleFeatureStore;
import org.geotools.feature.FeatureCollection;
import org.geotools.feature.FeatureIterator;
import org.geotools.feature.simple.SimpleFeatureTypeBuilder;
import org.geotools.feature.type.GeometryTypeImpl;
import org.junit.jupiter.api.Test;
import org.opengis.feature.Property;
import org.opengis.feature.simple.SimpleFeature;
import org.opengis.feature.simple.SimpleFeatureType;

import java.io.File;
import java.io.IOException;
import java.nio.charset.Charset;
import java.util.HashMap;
import java.util.Map;

@Slf4j
public class GeotoolsTests {

    @Test
    void 필드_추가() throws IOException {
    }

    @Test
    void 필드_삭제() throws IOException {
        FeatureSource<SimpleFeatureType, SimpleFeature> featureSource = getShape();
        FeatureCollection<SimpleFeatureType, SimpleFeature> features = featureSource.getFeatures();
        SimpleFeatureType schema = features.getSchema();
        SimpleFeatureTypeBuilder builder = new SimpleFeatureTypeBuilder();
        builder.remove("enable_yn");
        SimpleFeatureType outType = builder.buildFeatureType();
//        SimpleFeatureSource Source = dataStore.getFeatureSource(schema.getName().getLocalPart());
        FeatureIterator<SimpleFeature> attributes = features.features();
        while (attributes.hasNext()) {
            SimpleFeature feature = attributes.next();
            log.info(feature.getID() + ": ");
            for (Property attribute : feature.getProperties()) {
                if (attribute.getType() instanceof GeometryTypeImpl) {
                    log.info("\t\t" + attribute.getName() + ":" + attribute.getValue());
                } else {
                    log.info("\t" + attribute.getName() + ":" + attribute.getValue());
                }
            }
        }
    }

    @Test
    void shape파일_인코딩_설정() throws IOException {
        FeatureSource<SimpleFeatureType, SimpleFeature> featureSource = getShape();
        FeatureCollection<SimpleFeatureType, SimpleFeature> result = featureSource.getFeatures();
        System.out.println("Geographical elements [records]:" + result.size() + "individual");
        System.out.println("==================================");
        try (FeatureIterator<SimpleFeature> features = result.features()) {
            while (features.hasNext()) {
                SimpleFeature feature = features.next();
                log.info(feature.getID() + ": ");
                for (Property attribute : feature.getProperties()) {
                    if (attribute.getType() instanceof GeometryTypeImpl) {
                        log.info("\t\t" + attribute.getName() + ":" + attribute.getValue());
                    } else {
                        log.info("\t" + attribute.getName() + ":" + attribute.getValue());
                    }
                }
            }
        }
    }

    @Test
    void 인코딩판별() {

    }

    @Test
    void 좌표계_변경() {

    }

    @Test
    void shape스키마_이름변경_DB_insert() throws IOException {
        // db init
        Map<String, Object> params = new HashMap<>();
        params.put("dbtype", "postgis");
        params.put("host", "localhost");
        params.put("port", 5432);
        params.put("schema", "public");
        params.put("database", "ndtp");
        params.put("user", "postgres");
        params.put("passwd", "postgres");
        DataStore  dataStore = DataStoreFinder.getDataStore(params);
        log.info("dataStore ===================== {} " , dataStore);
        FeatureSource<SimpleFeatureType, SimpleFeature> shapeFeatureSource = getShape();
        FeatureCollection<SimpleFeatureType, SimpleFeature> features = shapeFeatureSource.getFeatures();
        SimpleFeatureType schema = features.getSchema();
        SimpleFeatureTypeBuilder builder = new SimpleFeatureTypeBuilder();
        // layerKey 로 rename
        builder.setName("test_table");
        builder.setSuperType((SimpleFeatureType) schema.getSuper());
        builder.addAll(schema.getAttributeDescriptors());
        schema = builder.buildFeatureType();
        log.info("schema ============== {} " , schema);

        try {
            /*
             * Write the features
             */
            Transaction transaction = new DefaultTransaction("shape");

            String[] typeNames = dataStore.getTypeNames();
            //first check if we need to create table
            boolean exists = false;
            String schemaName = schema.getName().getLocalPart();
            log.info("schemaName ============== {} ", schemaName);
            for (String name : typeNames) {
                log.info("typeName ============  {} ", name);
                if (schemaName.equalsIgnoreCase(name)) {
                    exists = true;
                    break;
                }
            }
            // 테이블이 없다면 생성
            if (!exists) {
                dataStore.createSchema(schema);
            }
            //we should probably check the schema matches the existing table.
            SimpleFeatureSource featureSource = dataStore.getFeatureSource(schema.getName().getLocalPart());
            if (featureSource instanceof SimpleFeatureStore) {
                SimpleFeatureStore featureStore = (SimpleFeatureStore) featureSource;

                featureStore.setTransaction(transaction);
                try {
                    featureStore.addFeatures(features);
                    transaction.commit();
                } catch (Exception problem) {
                    problem.printStackTrace();
                    transaction.rollback();
                } finally {
                    transaction.close();
                }
                dataStore.dispose();
            } else {
                dataStore.dispose();
                System.err.println("Database not writable");
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

    }

    @Test
    void sqlExport() {

    }

    private FeatureSource<SimpleFeatureType, SimpleFeature> getShape() throws IOException {
        // shape load
        ShapefileDataStore shpDataStore = new ShapefileDataStore(new File("D:\\test\\layer_lot_number_00000000.shp").toURI().toURL());
        shpDataStore.setCharset(Charset.forName("CP949"));
        String typeName = shpDataStore.getTypeNames()[0];
        log.info("shp[Layer) Name: {} ", typeName);
        FeatureSource<SimpleFeatureType, SimpleFeature> shapeFeatureSource = shpDataStore.getFeatureSource(typeName);

        return shapeFeatureSource;
    }
}
