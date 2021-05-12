#!/bin/bash

# ndtp-db

pg_restore -U postgres -F t -d ndtp /home/district/dist_layer.tar
pg_restore -U postgres -F t -d ndtp /home/district/dist_layer_group.tar

pg_restore -U postgres -F t -d ndtp /home/district/sk_sdo.tar
pg_restore -U postgres -F t -d ndtp /home/district/sk_sgg.tar
pg_restore -U postgres -F t -d ndtp /home/district/sk_emd.tar