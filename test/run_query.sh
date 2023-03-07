
## run_query.sh

TOP_LOC=../dependencies/geomodelgrids-build/bin/.libs

rm -rf sfcvm_depth.in sfcvm_depth.out sfcvm_elev.in sfcvm_elev.out sfcvm_depth.surf
rm -rf sfcvm_latlon.in sfcvm_latlon.surf


cat << LL &> sfcvm_latlon.in
37.455 -121.941
37.455 -121.941 
37.479 -121.734 
37.381 -121.581
LL

#           x0            x1    elevation
#  3.745500e+01 -1.219410e+02  1.046728e+00
#  3.745500e+01 -1.219410e+02  1.046728e+00
#  3.747900e+01 -1.217340e+02  4.815300e+02
#  3.738100e+01 -1.215810e+02  5.740770e+02


cat << LLL &> sfcvm.in
37.455 -121.941 -101.46
37.455 -121.941 0.0
37.455 -121.941 1.0467
37.455 -121.941 100.0
37.455 -121.941 1000.
LLL

cat << XLLL &> sfcvmm.in
37.455 -121.941 101.046728
37.455 -121.941 1.046728
37.455 -121.941 0
37.455 -121.941 -101.046728
37.455 -121.941 -1001.046728
XLLL

cat sfcvm.in

echo "\n====== none "
${TOP_LOC}/geomodelgrids_query \
--models=../data/sfcvm/USGS_SFCVM_v21-1_detailed.h5 \
--points=./sfcvm.in \
--output=./sfcvm.out \
--values=Vs,Vp,density \
--squash-min-elev=2000 \
--points-coordsys=EPSG:4326 

cat sfcvm.out 

exit

echo "\n====== top_surface "
${TOP_LOC}/geomodelgrids_query \
--models=../data/sfcvm/USGS_SFCVM_v21-1_detailed.h5 \
--points=./sfcvm.in \
--output=./sfcvm2.out \
--values=Vs,Vp,density \
--squash-min-elev=-2000 \
--squash-surface=top_surface \
--points-coordsys=EPSG:4326 

cat sfcvm2.out

#${TOP_LOC}/geomodelgrids_queryelev \
#--models=../data/sfcvm/USGS_SFCVM_v21-1_detailed.h5 \
#--points=./sfcvm_latlon.in \
#--output=./sfcvm_latlon.surf \
#--points-coordsys=EPSG:4326 \
#--surface=top_surface
=======
TOP_LOC=${UCVM_SRC_PATH}/work/model/sfcvm/dependencies/geomodelgrids-build/bin

cat << LATLONE &> one-block-flat_latlon_elev.in
37.455 -121.941 0.0
37.455 -121.941 -500.0
37.479 -121.734 -5.0e+3
37.381 -121.581 -3.0e+3
LATLONE

cat << LATLON &> one-block-flat_latlon.in
37.455 -121.941
37.455 -121.941
37.479 -121.734
37.381 -121.581
LATLON


${TOP_LOC}/geomodelgrids_query \
--models=../dependencies/geomodelgrids/tests/data/one-block-topo.h5,../dependencies/geomodelgrids/tests/data/three-blocks-flat.h5 \
--points=./one-block-flat_latlon_elev.in \
--output=./one-block-flat_latlon_elevX.out \
--values=one,two \
--points-coordsys=EPSG:4326 

cat one-block-flat_latlon_elevX.out

${TOP_LOC}/geomodelgrids_queryelev \
--models=../dependencies/geomodelgrids/tests/data/one-block-topo.h5 \
--points=./one-block-flat_latlon.in \
--output=./one-block-flat_latlon_surf.out \
--points-coordsys=EPSG:4326 \
--surface=top_surface

cat one-block-flat_latlon_surf.out

${TOP_LOC}/geomodelgrids_queryelev \
--models=../dependencies/geomodelgrids/tests/data/one-block-topo.h5 \
--points=./one-block-flat_latlon.in \
--output=./one-block-flat_latlon_topo.out \
--points-coordsys=EPSG:4326 \
--surface=topography_bathymetry

cat one-block-flat_latlon_topo.out


cat <<  UTME &> one-block-flat_utm_elev.in
593662.64 4145875.37 0.00
593662.64 4145875.37 -500.00
611935.55 4148764.09 -5000.00
625627.70 4138083.87 -3000.00
UTME

${TOP_LOC}/geomodelgrids_query \
--models=../dependencies/geomodelgrids/tests/data/one-block-topo.h5,../dependencies/geomodelgrids/tests/data/three-blocks-flat.h5 \
--points=./one-block-flat_utm_elev.in \
--output=./one-block-flat_utm_elevX.out \
--values=one,two \
--points-coordsys=EPSG:26910 


cat one-block-flat_utm_elevX.out

