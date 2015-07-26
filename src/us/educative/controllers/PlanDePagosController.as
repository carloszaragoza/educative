package us.educative.controllers
{
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import org.swizframework.controller.AbstractController;
	
	import us.educative.events.PlanDePagosEvent;
	import us.educative.models.PlanDePagosModel;
	import us.educative.services.PlanDePagosService;
	
	public class PlanDePagosController extends AbstractController
	{
		private var planDePagosService:PlanDePagosService = new PlanDePagosService();
		
		[Inject]
		public var planDePagosModel:PlanDePagosModel;
		
		public function PlanDePagosController()
		{
			super();
		}
		
		[PostConstruct]
		public function init():void
		{
			dispatcher.dispatchEvent(new PlanDePagosEvent(PlanDePagosEvent.PLAN_TRAER_TODOS_LOS_ALUMNOS));
			dispatcher.dispatchEvent(new PlanDePagosEvent(PlanDePagosEvent.PLAN_LISTAR_PLANES));
		}
		
		[EventHandler(event="PlanDePagosEvent.PLAN_TRAER_TODOS_LOS_ALUMNOS")]
		public function traerTodosLosAlumnosController():void{
			executeServiceCall(planDePagosService.getAllAlumnos(), getAllAlumnosResult, planDePagosFault);
		}
		
		private function getAllAlumnosResult(event:ResultEvent):void
		{
			if(event.result.hasOwnProperty('error')){
				Alert.show(event.result.error, "Error");
			}else
			{
				planDePagosModel.alumnosList = new ArrayCollection(event.result as Array);
			}
			
		}
		
		private function planDePagosFault(event:FaultEvent):void
		{
			// TODO Auto Generated method stub
			Alert.show("ERROR: "+event.fault.faultString,  "Error IO");
		}
		[EventHandler(event="PlanDePagosEvent.PLAN_LISTAR_PLANES")]
		public function listarPlanesDePagosController():void
		{
			executeServiceCall(planDePagosService.getAllPlanes(), getAllPlanesResult, planDePagosFault);
		}
		
		private function getAllPlanesResult(event:ResultEvent):void
		{
			if(event.result.hasOwnProperty('error')){
				Alert.show(event.result.error, "Error");
			}else
			{
				planDePagosModel.planesList = new ArrayCollection(event.result as Array);
			}
		}
		
		[EventHandler(event="PlanDePagosEvent.PLAN_BUSCA_CONCEPTOS_POR_ALUMNO", properties="alumno")]
		public function buscaConceptosPorAlumnoController(alumno:Object):void
		{
			executeServiceCall(planDePagosService.buscaConceptosPorAlumno(alumno), buscaConceptosPorAlumnoResult, planDePagosFault);
		}
		
		private function buscaConceptosPorAlumnoResult(event:ResultEvent):void
		{
			if(event.result.hasOwnProperty('error')){
				Alert.show(event.result.error, "Error");
			}else
			{
				planDePagosModel.conceptosDePagoList = new ArrayCollection(event.result as Array);
				
			}
		}
		
		[EventHandler(event="PlanDePagosEvent.PLAN_BORRAR_CONCEPTO_DE_PAGO", properties="id_registro_pago")]
		public function borrarConceptoDePagoController(id_registro_pago:int):void
		{
			executeServiceCall(planDePagosService.borrarConcepto(id_registro_pago), borrarConceptoResult, planDePagosFault);
		}
		
		private function borrarConceptoResult(event:ResultEvent):void
		{
			// TODO Auto Generated method stub
			if(event.result.hasOwnProperty('error')){
				Alert.show(event.result.error, "Error");
			}else
			{
				Alert.show("Se ha borrando el concepto");
				//Dispara evento para actualizar el registro
				dispatcher.dispatchEvent(new PlanDePagosEvent(PlanDePagosEvent.PLAN_VIEW_ALUMNO_SELECCIONADO));
			}
		}
		
		[EventHandler(event="PlanDePagosEvent.PLAN_LISTAR_PRODUCTO_SERVICIO", properties="busqueda")]
		public function listaProductoServicioController(busqueda:Object):void
		{
			executeServiceCall(planDePagosService.getAllProductoServicio(busqueda), getAllProductoServicioResult, planDePagosFault);
		}
		
		private function getAllProductoServicioResult(event:ResultEvent):void
		{
			if(event.result.hasOwnProperty('error')){
				Alert.show(event.result.error, "Error");
			}else
			{
				planDePagosModel.productoServicioList = new ArrayCollection(event.result as Array);
			}
		}
		
		[EventHandler(event="PlanDePagosEvent.PLAN_AGREGAR_CONCEPTO", properties="concepto")]
		public function agregarConceptoController(concepto:Object):void
		{
			executeServiceCall(planDePagosService.agregarConcepto(concepto), agregarConceptoResult, planDePagosFault);
		}
		
		private function agregarConceptoResult(event:ResultEvent):void
		{
			dispatcher.dispatchEvent(new PlanDePagosEvent(PlanDePagosEvent.PLAN_VIEW_ALUMNO_SELECCIONADO));
			if(event.result.hasOwnProperty('error')){
				Alert.show(event.result.error, "Error");
			}else
			{
				
				Alert.show("Se agrego el concepto");
				
				
			}
		}
		
		[EventHandler(event = "PlanDePagosEvent.PLAN_APLICAR", properties="objeto")]
		public function aplicaPlanDePagosController(objeto:Object):void
		{
			executeServiceCall(planDePagosService.aplicaPlan(objeto), aplicaPlanResult, planDePagosFault);
		}
		
		private function aplicaPlanResult(event:ResultEvent):void
		{
			// TODO Auto Generated method stub
			if(event.result.hasOwnProperty('error')){
				Alert.show(event.result.error, "Error");
			}else{
				Alert.show("Se cargo el plan de pagos completo");
				dispatcher.dispatchEvent(new PlanDePagosEvent(PlanDePagosEvent.PLAN_VIEW_ALUMNO_SELECCIONADO));
			}
		}
		
	}
}