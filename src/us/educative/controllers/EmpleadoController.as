package us.educative.controllers
{
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import org.swizframework.controller.AbstractController;
	
	import us.educative.VO.EmpleadoVO;
	import us.educative.events.EmpleadoEvent;
	import us.educative.models.EmpleadoModel;
	import us.educative.services.EmpleadoService;
	
	public class EmpleadoController extends AbstractController
	{
		[Inject]
		public var empleadoModel:EmpleadoModel;
		private var empleadoService:EmpleadoService = new EmpleadoService();
		public function EmpleadoController()
		{
			super();
		}
		
		[EventHandler(event="EmpleadoEvent.EMPLEADO_GUARDAR", properties="empleado")]
		public function sendEmpleadotoService(empleado:EmpleadoVO):void
		{
			executeServiceCall(empleadoService.save(empleado), saveResult, empleadoFault);
		}
		
		private function saveResult(event:ResultEvent):void
		{
			if(event.result.hasOwnProperty('error')){
				Alert.show(event.result.error, "Error");
			}else
			{
				Alert.show("Se guardo correctamente");
				dispatcher.dispatchEvent(new EmpleadoEvent(EmpleadoEvent.EMPLEADO_LIMPIA_FORMULARIO));
			}
		}
		private function empleadoFault(event:FaultEvent):void
		{
			// TODO Auto Generated method stub
			Alert.show(event.fault.message,"Hay problemas");
		}
		
		[EventHandler(event="EmpleadoEvent.EMPLEADO_BUSQUEDA_POR_FILTRO", properties="busqueda")]
		public function getAllByFilter(busqueda:String):void
		{
			executeServiceCall(empleadoService.getAllByFilter(busqueda),getAllByFilterResult, empleadoFault);
		}
		
		private function getAllByFilterResult(event:ResultEvent):void
		{
			// TODO Auto Generated method stub
			if(event.result.hasOwnProperty('error')){
				Alert.show(event.result.error, "Error");
			}else
			{
				empleadoModel.empleadoList = new ArrayCollection(event.result as Array);	
			}
			
		}
		
		[EventHandler(event="EmpleadoEvent.EMPLEADO_DELETE", properties="objeto")]
		public function deleteRecord(objeto:Object):void
		{
			executeServiceCall(empleadoService.deleteRecord(objeto), deleteRecordResutl, empleadoFault);
		}
		
		private function deleteRecordResutl(event:ResultEvent):void
		{
			if(event.result.hasOwnProperty('error')){
				Alert.show(event.result.error, "Error");
			}else{
				Alert.show("Se borro completamente","");
				dispatcher.dispatchEvent(new EmpleadoEvent(EmpleadoEvent.EMPLEADO_VISTA_BUSCA));
			}
		}
		
		[EventHandler(event="EmpleadoEvent.EMPLEADO_UPDATE", properties="empleado")]
		public function update(empleado:EmpleadoVO):void
		{
			executeServiceCall(empleadoService.update(empleado), updateResutl, empleadoFault);
		}
		
		private function updateResutl(event:ResultEvent):void
		{
			// TODO Auto Generated method stub
			if(event.result.hasOwnProperty('error')){
				Alert.show(event.result.error, "Error");
			}else
			{
				Alert.show("Se actualizo correctamente");
				dispatcher.dispatchEvent(new EmpleadoEvent(EmpleadoEvent.EMPLEADO_LIMPIA_FORMULARIO_UPDATE));
			}
		}
		
	}
}