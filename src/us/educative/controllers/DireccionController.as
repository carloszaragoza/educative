package us.educative.controllers
{
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import org.swizframework.controller.AbstractController;
	
	import us.educative.VO.EntidadVO;
	import us.educative.VO.LocalidadVO;
	import us.educative.VO.MunicipioVO;
	import us.educative.events.DireccionEvent;
	import us.educative.models.DireccionModel;
	import us.educative.services.*;
	
	public class DireccionController extends AbstractController
	{
		public var direccionService:DireccionService = new DireccionService();
		public function DireccionController()
		{
			super();
		}
		[Inject]
		public var direccionModel:DireccionModel;
		[PostConstruct]
		public function init():void
		{
			
		}
		
		[EventHandler(event="DireccionEvent.ENTIDAD_LIST_DATA", properties="entidadVO")]
		public function getListEntidad(entidad:EntidadVO):void
		{
			trace("Event-----> ENTIDAD_LIST_DATA");
			
			executeServiceCall(direccionService.catEntidadService(),catEntidadResult,direccionFault);
		}
		
		private function direccionFault(event:FaultEvent):void
		{
			// TODO Auto Generated method stub
			Alert.show(event.message.toString(),"Error");
		}
		
		private function catEntidadResult(event:ResultEvent):void
		{
			// TODO Auto Generated method stub
			try
			{
				direccionModel.acListEntidad = event.result as ArrayCollection	
			} 
			catch(error:Error) 
			{
				Alert.show(error.message,"Error");
			}
			
		}
		
		[EventHandler(event="DireccionEvent.MUNICIPIO_LIST_DATA", properties="municipioVO")]
		public function getListMunicipio(municipio:MunicipioVO):void
		{
			trace("Event-----> MUNICIPIO_LIST_DATA");
			
			executeServiceCall(direccionService.catMunicipioService(municipio),catMunicipioResult,direccionFault);
		}
		
		private function catMunicipioResult(event:ResultEvent):void
		{
			// TODO Auto Generated method stub
			try
			{
				direccionModel.acListMunicipio = new ArrayCollection(event.result as Array);
				if(direccionModel.entidadLocated)
				{
					var localizaMunicipioEvent:DireccionEvent  = new DireccionEvent(DireccionEvent.LOCALIZA_MUNICIPIO);
					dispatcher.dispatchEvent(localizaMunicipioEvent);
				}
			}
			catch(error:Error) 
			{
				Alert.show(error.message, "Error");
			}
			
		}
		
		[EventHandler(event="DireccionEvent.LOCALIDAD_LIST_DATA", properties="localidadVO")]
		public function getListLocalidad(localidad:LocalidadVO):void
		{
			trace("Event-----> LOCALIDAD_LIST_DATA");
			
			executeServiceCall(direccionService.catLocalidadService(localidad),catLocalidadResult,direccionFault);
		}
		
		private function catLocalidadResult(event:ResultEvent):void
		{
			// TODO Auto Generated method stub
			try
			{
				direccionModel.acListLocalidad = new ArrayCollection(event.result as Array);	
				if(direccionModel.municipioLocated)
				{
					var localizaLocalidadEvent:DireccionEvent  = new DireccionEvent(DireccionEvent.LOCALIZA_LOCALIDAD);
					dispatcher.dispatchEvent(localizaLocalidadEvent);
				}
			} 
			catch(error:Error) 
			{
				Alert.show(error.message, "Error");
			}
			
		}
	}
}