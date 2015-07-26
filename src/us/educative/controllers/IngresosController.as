/**
 * Created by carlos on 8/13/14.
 */
package us.educative.controllers {
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import org.swizframework.controller.AbstractController;
	
	import us.educative.VO.IngresosVO;
	import us.educative.events.IngresosEvent;
	import us.educative.models.IngresosModel;
	import us.educative.services.IngresosService;
	
	public class IngresosController extends AbstractController {
		private var ingresosService:IngresosService = new IngresosService();
		
		public function IngresosController() {
			super();
		}
		
		[Inject]
		public var ingresosModel:IngresosModel;
		
		[EventHandler(event="IngresosEvent.INGRESOS_GET_ALL_GRUPOS", properties="busqueda")]
		public function getAllGruposController(busqueda:Object):void
		{
			executeServiceCall(ingresosService.getAllGrupos(busqueda), getAllGruposResult, ingresosFault);
		}
		
		private function getAllGruposResult(event:ResultEvent):void {
			if(event.result.hasOwnProperty('error')){
				Alert.show(event.result.error, "Error");
			}else{
				//grupos
				ingresosModel.listadoGruposIngresos = new ArrayCollection(event.result as Array);
			}
		}
		
		private function ingresosFault(event:FaultEvent):void {
			Alert.show(event.fault.message,"Error IO");
		}
		
		[EventHandler(event="IngresosEvent.INGRESOS_GET_ALL_ALUMNOS", properties="busqueda")]
		public function getAllAlumnosController(busqueda:Object):void
		{
			executeServiceCall(ingresosService.getAllAlumnosService(busqueda), getAllAlumnosResultado, ingresosFault);
		}
		
		private function getAllAlumnosResultado(event:ResultEvent):void {
			
			if(event.result.hasOwnProperty('error')){
				Alert.show(event.result.error, "Error");
			}else{
				ingresosModel.listadoAlumnos = new ArrayCollection(event.result as Array);
			}
		}
		
		[EventHandler(event="IngresosEvent.INGRESOS_GET_ALL_CONCEPTOS", properties="id_nivel_educativo")]
		public function getAllConceptosController(id_nivel_educativo:int):void{
			executeServiceCall(ingresosService.getAllConceptos(id_nivel_educativo), getAllConceptosResult, ingresosFault);
		}
		
		private function getAllConceptosResult(event:ResultEvent):void {
			if(event.result.hasOwnProperty('error')){
				Alert.show(event.result.error, "Error");
			}else{
				ingresosModel.listadoConceptos = new ArrayCollection(event.result as Array);
			}
		}
		
		[EventHandler(event="IngresosEvent.INGRESOS_PAGO_ALUMNO", properties="pago")]
		public function pagoController(pago:IngresosVO):void
		{
			executeServiceCall(ingresosService.savePago(pago), savePagoResult, ingresosFault);
		}
		
		private function savePagoResult(event:ResultEvent):void {
			if(event.result.hasOwnProperty('error')){
				Alert.show(event.result.error, "Error");
			}else if(event.result.hasOwnProperty('info')){
				Alert.show(event.result.info, "Info");
			}else{
				//
				Alert.show("El pago se realizó");
				dispatcher.dispatchEvent(new IngresosEvent(IngresosEvent.INGRESOS_BUSQUEDA_PAGOS));
			}
		}
		
		[EventHandler(event="IngresosEvent.INGRESOS_TODOS_LOS_PAGOS_DEL_ALUMNO", properties="alumno")]
		public function traerTodosLosPagosController(alumno:Object):void
		{
			executeServiceCall(ingresosService.getAllPagosByAlumnoGeneral(alumno), getAllPagosByAlumnoResult, ingresosFault);
		}
		
		private function getAllPagosByAlumnoResult(event:ResultEvent):void
		{
			if(event.result.hasOwnProperty('error')){
				Alert.show(event.result.error, "Error");
			}else{
				ingresosModel.listadoPagos = new ArrayCollection(event.result as Array);
			}
		}
		
		[EventHandler(event="IngresosEvent.INGRESOS_TRAE_TODOS_LOS_ALUMNOS")]
		public function traeTodosLosAlumnosController():void
		{
			executeServiceCall(ingresosService.getAllAlumnosListado(), getAllAlumnosListadoResult, ingresosFault);
		}
		
		private function getAllAlumnosListadoResult(event:ResultEvent):void
		{
			if(event.result.hasOwnProperty('error')){
				Alert.show(event.result.error, "Error");
			}else{	
				ingresosModel.listadoAlumnos =  new ArrayCollection(event.result as Array)
			}
		}
		
		[EventHandler(event="IngresosEvent.INGRESOS_DETALLE_PAGO", properties="objeto")]
		public function ingresosDetallePagoController(objeto:Object):void{
			executeServiceCall(ingresosService.traeDetalleDePago(objeto), traeDetalleDePagoResult, ingresosFault);
		}
		
		private function traeDetalleDePagoResult(event:ResultEvent):void
		{
			// TODO Auto Generated method stub
			if(event.result.hasOwnProperty('error')){
				Alert.show(event.result.error, "Error");
			}else{
				ingresosModel.listadoPagosDetalle = new ArrayCollection(event.result as Array);
			}
		}
		
		[EventHandler(event="IngresosEvent.INGRESOS_BORRAR_PAGO", properties="objeto")]
		public function ingresosBorrarPagoController(objeto:Object):void{
			executeServiceCall(ingresosService.borrarPago(objeto), borrarPagoResult, ingresosFault);
		}
		
		private function borrarPagoResult(event:ResultEvent):void
		{
			// TODO Auto Generated method stub
			if(event.result.hasOwnProperty('error')){
				Alert.show(event.result.error, "Error");
			}else{
				//Borro, hay que quitarlo del registro de la tabla y volver a cargar los valores del master.
				dispatcher.dispatchEvent(new IngresosEvent(IngresosEvent.INGRESOS_QUITAR_REGISTRO_GRID_BORRADO));
				dispatcher.dispatchEvent(new IngresosEvent(IngresosEvent.INGRESOS_BUSQUEDA_PAGOS));
			}
		}
		
	}
}
