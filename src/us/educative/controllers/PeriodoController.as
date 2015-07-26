package us.educative.controllers
{
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import org.swizframework.controller.AbstractController;
	
	import us.educative.VO.PeriodoVO;
	import us.educative.events.PeriodoEvent;
	import us.educative.models.PeriodoModel;
	import us.educative.services.PeriodoService;
	
	public class PeriodoController extends AbstractController
	{
		private var periodoService:PeriodoService = new PeriodoService();
		
		[Inject]
		public var periodoModel:PeriodoModel;
		
		public function PeriodoController()
		{
			super();
		}
		[EventHandler(event="PeriodoEvent.PERIODO_SAVE", properties="periodo")]
		public function sendPeriodoToService(periodo:PeriodoVO):void
		{
			executeServiceCall(periodoService.save(periodo), saveResult, periodoFault);
		}
		
		private function saveResult(event:ResultEvent):void
		{
			if(event.result.hasOwnProperty('error')){
				Alert.show(event.result.error, "Error");
			}else{
				if(event.result){
					Alert.show("Se guardo correctamente");
					dispatcher.dispatchEvent(new PeriodoEvent(PeriodoEvent.PERIODO_LIMPIA_FORMULARIO));
				}	
			}
			
		}
		
		private function periodoFault(event:FaultEvent):void
		{
			Alert.show(event.fault.message,"Error");
		}
		[EventHandler(event="PeriodoEvent.PERIODO_UPDATE", properties="periodo")]
		public function sendPeriodoToUpdate(periodo:PeriodoVO):void
		{
			executeServiceCall(periodoService.update(periodo), updateResult, periodoFault);
		}
		
		private function updateResult(event:ResultEvent):void
		{
			// TODO Auto Generated method stub
			if(event.result.hasOwnProperty('error')){
				Alert.show(event.result.error, "Error");
			}else{
				Alert.show("Se actualizó correctamente");
				dispatcher.dispatchEvent(new PeriodoEvent(PeriodoEvent.PERIODO_LIMPIA_FORMULARIO_UPDATE));
			}
		}
		
		
		//PeriodoEvent.PERIODO_DELETE
		[EventHandler(event="PeriodoEvent.PERIODO_DELETE", properties="datagrid")]
		public function sendPeriodoToDelete(data:Object):void
		{
			executeServiceCall(periodoService.deleteRecord(data), deleteRecordResult, periodoFault);
		}
		
		private function deleteRecordResult(event:ResultEvent):void
		{
			// TODO Auto Generated method stub
			if(event.result.hasOwnProperty('error')){
				Alert.show(event.result.error, "Error");
			}else{
				Alert.show("Se borro el registro");
				dispatcher.dispatchEvent(new PeriodoEvent(PeriodoEvent.PERIODO_VISTA_BUSCA));
			}
		}		
		
		[EventHandler(event="PeriodoEvent.PERIODO_BUSQUEDA_POR_FILTRO", properties="busqueda")]
		public function periodoBusquedaFiltro(busqueda:String):void
		{
			executeServiceCall(periodoService.getAllByFilter(busqueda), getAllByFilterResult, periodoFault);
		}
		
		private function getAllByFilterResult(event:ResultEvent):void
		{
			if(event.result.hasOwnProperty('error')){
				Alert.show(event.result.error, "Error");
			}else{
				periodoModel.periodoList = new ArrayCollection(event.result as Array);
			}
		}
	}
}