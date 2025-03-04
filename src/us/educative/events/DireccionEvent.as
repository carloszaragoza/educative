package us.educative.events
{
	import us.educative.VO.EntidadVO;
	import us.educative.VO.LocalidadVO;
	import us.educative.VO.MunicipioVO;
	
	import flash.events.Event;
	
	public class DireccionEvent extends Event
	{
		public static const ENTIDAD_LIST_DATA:String = "entidadListData";
		public static const MUNICIPIO_LIST_DATA:String = "municipioListData";
		public static const LOCALIDAD_LIST_DATA:String = "localidadListData";
		
		public static const LOCALIZA_MUNICIPIO:String = "localizaMunicipio";
		public static const LOCALIZA_LOCALIDAD:String = "localizaLocalidad";
		
		public var entidadVO:EntidadVO;
		public var municipioVO:MunicipioVO;
		public var localidadVO:LocalidadVO;
		public function DireccionEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}