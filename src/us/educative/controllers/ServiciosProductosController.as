/**
 * Created by carlos on 8/11/14.
 */
package us.educative.controllers {
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import org.swizframework.controller.AbstractController;
	
	import us.educative.VO.ServiciosProductosVO;
	import us.educative.events.ServiciosProductosEvent;
	import us.educative.models.ServiciosProductosModel;
	import us.educative.services.ServiciosProductosService;
	
	public class ServiciosProductosController extends AbstractController {
		
		private var serviciosProductosService:ServiciosProductosService = new ServiciosProductosService();
		
		[Inject] public var serviciosProductosModel:ServiciosProductosModel;
		
		public function ServiciosProductosController() {
			super();
		}
		[EventHandler(event="ServiciosProductosEvent.SERVICIOS_PRODUCTOS_GET_BY_FILTER", properties="busquedObjeto")]
		public function getByFilter(busquedObjecto:Object):void
		{
			executeServiceCall(serviciosProductosService.getByFilter(busquedObjecto), getByFilterResult, serviciosProductosFault);
		}
		
		private function getByFilterResult(event:ResultEvent):void {
			if(event.result.hasOwnProperty('error')){
				Alert.show(event.result.error, "Error");
			}else if(event.result != false)
			{
				serviciosProductosModel.catalogoPagosList = new ArrayCollection(event.result as Array);
			}else{
				Alert.show("No se encontro coincidencias","Busqueda");
			}
		}
		
		private function serviciosProductosFault(event:FaultEvent):void {
			Alert.show(event.fault.message, "Error NET");
		}
		
		[EventHandler(event="ServiciosProductosEvent.SERVICIOS_PRODUCTOS_GUARDAR", properties="serviciosProductos")]
		public function guardarProductosController(serviciosProductos:ServiciosProductosVO):void
		{
			executeServiceCall(serviciosProductosService.save(serviciosProductos), saveResult, serviciosProductosFault);
		}
		
		private function saveResult(event:ResultEvent):void
		{
			// TODO Auto Generated method stub
			if(event.result.hasOwnProperty('error')){
				Alert.show(event.result.error, "Error");
			}else if(event.result != false)
			{
				Alert.show("Se guardo correctamente");
				//Lanzar evento para limpiar datos
				dispatcher.dispatchEvent(new ServiciosProductosEvent(ServiciosProductosEvent.SERVICIOS_PRODUCTOS_LIMPIA_FORMULARIO));
			}
		}	
		
		
		[EventHandler(event="ServiciosProductosEvent.SERVICIOS_PRODUCTOS_ACTUALIZAR", properties="serviciosProductos")]
		public function actualizarController(serviciosProductos:ServiciosProductosVO):void
		{
			executeServiceCall(serviciosProductosService.actualizar(serviciosProductos), actualizarResult, serviciosProductosFault);
		}
		
		public function actualizarResult(event:ResultEvent):void
		{
			if(event.result.hasOwnProperty('error')){
				Alert.show(event.result.error, "Error");
			}else if(event.result != false)
			{
				Alert.show("Se actualizo correctamente");
				//Lanzar evento para limpiar datos
				dispatcher.dispatchEvent(new ServiciosProductosEvent(ServiciosProductosEvent.SERVICIOS_PRODUCTOS_LIMPIA_FORMULARIO_UPDATE));
			}
		}
		
		[EventHandler(event="ServiciosProductosEvent.SERVICIOS_PRODUCTOS_BORRAR", properties="datagrid")]
		public function sendToDelete(datagrid:Object):void
		{
			executeServiceCall(serviciosProductosService.deleteSP(datagrid.id_producto_servicio),deleteResult, serviciosProductosFault);
		}
		
		private function deleteResult(event:ResultEvent):void
		{
			// TODO Auto Generated method stub
			if(event.result.hasOwnProperty('error')){
				Alert.show(event.result.error, "Error");
			}else if(event.result != false)
			{
				Alert.show("Se borro correctamente");
				//Lanzar evento para limpiar datos
				//dispatcher.dispatchEvent(new ServiciosProductosEvent(ServiciosProductosEvent.SERVICIOS_PRODUCTOS_LIMPIA_FORMULARIO_UPDATE));
			}
		}		
		
		
		
	}
}
