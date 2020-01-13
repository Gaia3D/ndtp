<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="analysisContent" class="contentsList yScroll" style="height: 798px;background-color: #fff;">
	<ul class="listDrop">
		<li class="on">
			<p>Radial Line Of Sight Analysis</p>
			<div class="listContents" id="analysisRadialLineOfSight">
				<ul class="analysisGroup">
					<li>
						<label for="">Analysis Data</label>
						<select class="dataType">
							<option value="DEM" selected="">DEM (DEM)</option>
							<option value="DSM">DSM (DSM)</option>
						</select>
					</li>
					<li>
						<label for="">Observer Offset (m)</label>
						<input class="observerOffset" type="text" placeholder="" value="1.7">
					</li>
					<li>
						<label for="">Radius (m)</label>
						<input class="radius" type="text" placeholder="" value="100">
					</li>
					<li>
						<label for="">Sides (number)</label>
						<input class="sides" type="text" placeholder="" value="90">
					</li>
					<li>
						<label for="">Observer Point</label>
						<input type="text" placeholder="" class="withBtn observerPointMGRS">
						<input type="hidden" class="observerPoint">
						<button type="button" class="btnText drawObserverPoint">Pick Location</button>
					</li>
					<li class="btns">
						<button type="button" class="btnTextF execute" title="Analysis">Analysis</button>
						<button type="button" class="btnText reset" title="Clear">Clear</button>
					</li>
				</ul>
			</div>
		</li>
		<li>
			<p>Linear Line Of Sight Analysis</p>
			<div class="listContents" id="analysisLinearLineOfSight">
				<ul class="analysisGroup">
					<li>
						<label for="">Analysis Data</label>
						<select class="dataType">
							<option value="DEM" selected="">DEM (DEM)</option>
							<option value="DSM">DSM (DSM)</option>
						</select>
					</li>
					<li>
						<label for="">Observer Offset (m)</label>
						<input class="observerOffset" type="text" placeholder="" value="1.7">
					</li>
					<li>
						<label for="">Observer Point</label>
						<input type="text" placeholder="" class="withBtn observerPointMGRS">
						<input type="hidden" class="observerPoint">
						<button type="button" class="btnText drawObserverPoint">Pick Location</button>
					</li>
					<li>
						<label for="">Target Point</label>
						<input type="text" placeholder="" class="withBtn targetPointMGRS">
						<input type="hidden" class="targetPoint">
						<button type="button" class="btnText drawTargetPoint">Pick Location</button>
					</li>
					<li class="btns">
						<button type="button" class="btnTextF execute" title="Analysis">Analysis</button>
						<button type="button" class="btnText reset" title="Clear">Clear</button>
					</li>
				</ul>
			</div>
		</li>
		<li>
			<p>RasterProfile Analysis</p>
			<div class="listContents" id="analysisRasterProfile">
				<ul class="analysisGroup">
					<li>
						<label for="">Analysis Data</label>
						<select class="dataType">
							<option value="DEM" selected="">DEM (DEM)</option>
							<option value="DSM">DSM (DSM)</option>
						</select>
					</li>
					<li>
						<label for="">Interval (number)</label>
						<input class="interval" type="text" placeholder="" value="20">
					</li>
					<li>
						<label for="">User Line</label>
						<button type="button" class="btnText drawUserLine">Pick Location</button>
						<input type="hidden" class="userLine">
						<div class="coordsText"></div>
					</li>
					<li class="btns">
						<button type="button" class="btnTextF execute" title="Analysis">Analysis</button>
						<button type="button" class="btnText reset" title="Clear">Clear</button>
					</li>

					<li class="profileInfo">
						<div class="legend"></div>
					</li>
				</ul>
			</div>
		</li>
		<li>
			<p>Raster High/Low Points Analysis</p>
			<div class="listContents" id="analysisRasterHighLowPoints">
				<ul class="analysisGroup">
					<li>
						<label for="">Analysis Data</label>
						<select class="dataType">
							<option value="DEM" selected="">DEM (DEM)</option>
							<option value="DSM">DSM (DSM)</option>
						</select>
					</li>
					<li>
						<label for="">Area Type</label>
						<select class="areaType">
							<option value="useArea">User Area</option>
							<option value="extent">Map Extent</option>
						</select>
					</li>
					<li class="wrapCropShape">
						<label for=""></label>
						<input type="hidden" class="cropShape">
						<button type="button" class="btnText drawCropShape">Crop Shape</button>
					</li>
					<li>
						<label for="">Value Type</label>
						<select class="valueType">
							<option value="High">High</option>
							<option value="Low">Low</option>
						</select>
					</li>
					<li class="btns">
						<input type="hidden" class="wcsExtent">
						<button type="button" class="btnTextF execute" title="Analysis">Analysis</button>
						<button type="button" class="btnText reset" title="Clear">Clear</button>
					</li>
				</ul>
			</div>
		</li>
		<li>
			<p>Threat Dome Analysis</p>
			<div class="listContents" id="analysisRangeDome">
				<ul class="analysisGroup">
					<li>
						<label for="">Radius (m)</label>
						<input class="radius" type="text" placeholder="" value="1000">
					</li>
					<li>
						<label for="">Observer Point</label>
						<input type="text" placeholder="" class="withBtn observerPointMGRS">
						<input type="hidden" class="observerPoint">
						<button type="button" class="btnText drawObserverPoint">Pick Location</button>
					</li>
					<li class="btns">
						<button type="button" class="btnTextF execute" title="Analysis">Analysis</button>
						<button type="button" class="btnText reset" title="Clear">Clear</button>
					</li>
				</ul>
			</div>
		</li>
	</ul>
</div>