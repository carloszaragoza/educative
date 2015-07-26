
package us.educative.views.components
{
	import flash.globalization.CurrencyFormatter;
	
	import mx.charts.CategoryAxis;
	import mx.charts.ChartItem;
	import mx.charts.HitData;
	import mx.charts.chartClasses.IAxis;
	import mx.charts.chartClasses.Series;
	import mx.charts.series.ColumnSeries;
	import mx.charts.series.items.ColumnSeriesItem;
	import mx.collections.ArrayCollection;
	import mx.formatters.Formatter;
	import mx.graphics.IFill;
	import mx.graphics.SolidColor;
	
	import spark.components.Group;
	
	import us.educative.events.CommonEvent;
	import us.educative.models.CommonModel;
	
	public class DashboardChartsBase extends Group
	{
		[Inject]
		[Bindable] public var commonModel:CommonModel;
		private var view:DashboardCharts = DashboardCharts(this);
		public var currencyFormatter:CurrencyFormatter;
		
		public function DashboardChartsBase()
		{
			super();
			currencyFormatter = new CurrencyFormatter('ES_mx');
			currencyFormatter.fractionalDigits = 2;
		}
		
		public function display(data:Object,field:String,index:Number,percentValue:Number):String
		{
			var texto:String = percentValue.toString();
			return data.tipo + " " + data.cantidad;
		}
		
		public function displayNivel(data:Object,field:String,index:Number,percentValue:Number):String
		{
			var texto:String = percentValue.toString();
			return data.nivel + "-" + data.grupo + ": "+ data.alumnos;
		}
		private static const fills:Array = [0x3359AC,0xE55A11,0x971733,
			0xDBDBDB,0x77B133,0x28B7CA,
			0x3359AC,0xE55A11,0x971733,
			0xDBDBDB,0x77B133,0x28B7CA];
		
		protected function barFillFunction(element:ChartItem, index:Number):IFill{
			
			var fill:Number = fills[index % fills.length];
			var color:SolidColor = new SolidColor(fill);
			return color;
		}
		
		private static const fills2:Array = [
			0xDBDBDB,0x77B133,0x28B7CA,
			0x3359AC,0xE55A11,0x971733,
			0xDBDBDB,0x77B133,0x28B7CA,0x3359AC,0xE55A11,0x971733];
		
		protected function barFillFunction2(element:ChartItem, index:Number):IFill{
			
			var fill:Number = fills2[index % fills.length];
			var color:SolidColor = new SolidColor(fill);
			return color;
		}
		
	
		public function linearAxis_labelFunc(item:Object, prevValue:Object, axis:IAxis):String {
			return currencyFormatter.format(Number(item));
		}
		
		public function formatDataTip(hd:HitData):String {
			
			var string:String;
			string = "<b>"+hd.item.mes+"</b><br>" + currencyFormatter.format(Number(hd.item.ingresos)).toString() + "<br><b>Por ingresar</b><br>"+  currencyFormatter.format(Number(hd.item.cantidad_por_pagar)).toString();
			return string;
		}
		
		public function formatDataTipNivel(hd:HitData):String {
			
			var string:String;
			string = "<b>"+hd.item.nivel+"</b><br>" + currencyFormatter.format(Number(hd.item.ingresos)).toString() + "<br><b>Por ingresar</b><br>"+  currencyFormatter.format(Number(hd.item.cantidad_por_pagar)).toString();
			return string;
		}
		public function refrescarGraficas():void
		{
			var eventChart:CommonEvent = new CommonEvent(CommonEvent.DASHBOARD_GET_CHARTS);
			dispatchEvent(eventChart);
		}
		
	}
}