Mago3D.ManagerUtils.geographicToWkt = function(geographic) {
	var wkt = 'POINT (';
	wkt += geographic.longitude;
	wkt += ' ';
	wkt += geographic.latitude;
	wkt += ')';
	
	return wkt;
}
