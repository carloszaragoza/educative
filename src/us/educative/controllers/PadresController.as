package us.educative.controllers
{
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import org.swizframework.controller.AbstractController;
	
	import us.educative.VO.FamiliaVO;
	import us.educative.events.PadresEvent;
	import us.educative.models.CommonModel;
	import us.educative.models.PadresModel;
	import us.educative.services.PadresService;
	import us.educative.views.components.Padres;
	
	public class PadresController extends AbstractController
	{
		[Inject]
		public var padresModel:PadresModel;
		
		[Inject]
		public var commonModel:CommonModel;
		
		private var padresServices:PadresService = new PadresService();
		public function PadresController()
		{
			//TODO: implement function
			super();
		}
		
		[PostConstruct]
		public function init():void
		{
			sendBusquedaPadresToService("");
		}
		
		[EventHandler(event="PadresEvent.PADRES_BUSQUEDA_POR_FILTRO", properties="busqueda")]
		public function sendBusquedaPadresToService(busqueda:String):void
		{
			executeServiceCall(padresServices.getAllByFilter(busqueda),getAllByFilterResult,padresFault);
		}
		
		private function getAllByFilterResult(event:ResultEvent):void
		{
			// TODO Auto Generated method stub
			try{
				if(event.result.hasOwnProperty('error')){
					Alert.show(event.result.error, "Error");
				}else{
				padresModel.padresList = new ArrayCollection(event.result as Array);
				commonModel.padresList = new ArrayCollection(event.result as Array);
				}
			}catch(e:Error)
			{
				Alert.show(e.message);
			}
			
		}
		
		[EventHandler(event="PadresEvent.PADRES_SAVE", properties = "familia")]
		public function sendPadresToService(familia:FamiliaVO):void
		{
			executeServiceCall(padresServices.save(familia), familiaSaveHandler, padresFault);
		}
		
		private function padresFault(event:FaultEvent):void
		{
			// TODO Auto Generated method stub
			Alert.show(event.fault.message,"Error");
		}
		
		private function familiaSaveHandler(event:ResultEvent):void
		{
			if(event.result.hasOwnProperty('error')){
				Alert.show(event.result.error, "Error");
			}else{
				Alert.show("Se guardo correctamente la familia");
				dispatcher.dispatchEvent(new PadresEvent(PadresEvent.PADRES_LIMPIA_FORMULARIO));
			}
		}
		
		[EventHandler(event="PadresEvent.PADRES_DELETE", properties="datagrid")]
		public function sendPadresDelete(datagrid:Object):void
		{
			executeServiceCall(padresServices.deletePadre(datagrid.id_tutor),deleteResult, padresFault);
		}
		
		private function deleteResult(event:ResultEvent):void
		{
			if(event.result.hasOwnProperty('error')){
				
				Alert.show(event.result.error, "Error");
			}else{
				Alert.show("Se ha borrado la familia","Éxito");
				var eventFiltro:PadresEvent = new PadresEvent(PadresEvent.PADRES_BUSQUEDA_POR_FILTRO);
				eventFiltro.busqueda = "";
				dispatcher.dispatchEvent(eventFiltro);
			}
				
		}
		
		[EventHandler(event="PadresEvent.PADRES_UPDATE", properties="familia")]
		public function sendPadresUpdate(familia:FamiliaVO):void
		{
			executeServiceCall(padresServices.updatePadre(familia),updateResult, padresFault);
		}
		
		private function updateResult(event:ResultEvent):void
		{
			if(event.result.hasOwnProperty('error')){
				Alert.show(event.result.error, "Error");
			}else{
				Alert.show("Se actualizó correctamente");	
				dispatcher.dispatchEvent(new PadresEvent(PadresEvent.PADRES_LIMPIA_FORMULARIO_UPDATE));
			}
			
		}
	}
}