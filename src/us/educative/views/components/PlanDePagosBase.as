package us.educative.views.components
{
	import flash.events.Event;
	
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	
	import spark.components.Group;
	
	import us.educative.events.PlanDePagosEvent;
	import us.educative.models.CommonModel;
	import us.educative.models.PlanDePagosModel;
	
	public class PlanDePagosBase extends Group
	{
		[Inject]
		[Bindable] public var planDePagosModel:PlanDePagosModel;
		
		[Inject]
		[Bindable] public var commonModel:CommonModel;
		
		
		private var view:PlanDePagos = PlanDePagos(this); //Creamos instancia del componente
		public function PlanDePagosBase()
		{
			super();
			
		}
		
		[EventHandler(event="PlanDePagosEvent.PLAN_VIEW_ALUMNO_SELECCIONADO")]
		public function alumnoSeleccionado(event:Event):void{
			//trae todos los conceptos del plan de pagos asignado en caso de que lo tenga
			if(view.ddlAlumno.selectedItem!=null){
				var id_control_inscripcion:int = view.ddlAlumno.selectedItem.id_control_inscripcion;
				var id_alumno:int = view.ddlAlumno.selectedItem.alumno_id;
				var eventBuscarConceptos:PlanDePagosEvent = new PlanDePagosEvent(PlanDePagosEvent.PLAN_BUSCA_CONCEPTOS_POR_ALUMNO);
				var alumno:Object = new Object();
				alumno.id_control_inscripcion = id_control_inscripcion;
				alumno.id_alumno = id_alumno;
				eventBuscarConceptos.alumno = alumno;
				dispatchEvent(eventBuscarConceptos);
			}
			if(planDePagosModel.productoServicioList){
				planDePagosModel.productoServicioList.removeAll();
				planDePagosModel.productoServicioList.refresh();
				view.gpoProducto.selected = false;
				view.gpoServicio.selected = false;	
			}
			
		}
		
		
		public var datas:Object;
		
		
		public function borrarConcepto(data:Object):void
		{
			datas = data;
			Alert.show("¿Estás seguro de borrar el concepto?","",3,this,iamShureToDelete);
			
		}
		public function iamShureToDelete(event:CloseEvent):void
		{
			if(event.detail == Alert.YES)
			{
				var eventBorrarConceptoDePago:PlanDePagosEvent = new PlanDePagosEvent(PlanDePagosEvent.PLAN_BORRAR_CONCEPTO_DE_PAGO);
				eventBorrarConceptoDePago.id_registro_pago =datas.id_registro_pago;
				dispatchEvent(eventBorrarConceptoDePago);
			}
		}
		
		public function agregaConcepto(data:Object):void
		{
			var eventAgregarConcepto:PlanDePagosEvent = new PlanDePagosEvent(PlanDePagosEvent.PLAN_AGREGAR_CONCEPTO);
			var rescate:Object = new Object()
				rescate.concepto = data;
				rescate.alumno = view.ddlAlumno.selectedItem;
				rescate.usuario = commonModel.id_usuario;
				rescate.mes_de_pago = mes_seleccionado;
			eventAgregarConcepto.concepto = rescate
			dispatchEvent(eventAgregarConcepto);
		}
		public var mes_seleccionado:int;
		public function cambioMes(event:Event):void{
			mes_seleccionado =event.target.selectedItem.data; 
		}
		
		public function traerListaDeConceptos(event:Event, tipo:String):void
		{
			var busqueda:Object = new Object();
			busqueda.tipo_pago = tipo;
			busqueda.periodo_id = view.ddlAlumno.selectedItem.periodo_id;
			busqueda.nivel_educativo_id = view.ddlAlumno.selectedItem.nivel_educativo_id;
			
			var eventListaConceptos:PlanDePagosEvent = new PlanDePagosEvent(PlanDePagosEvent.PLAN_LISTAR_PRODUCTO_SERVICIO);
			eventListaConceptos.busqueda = busqueda;
			dispatchEvent(eventListaConceptos);
		}
		
		public function aplicaPlanDePagos():void
		{
			Alert.show("¿Estás seguro de que este plan de pagos para tu alumno?","",3,this,seguroDeAplicar);
		}
		public function seguroDeAplicar(event:CloseEvent):void
		{
			if(event.detail == Alert.YES)
			{
				var eventAplicarPlan:PlanDePagosEvent = new PlanDePagosEvent(PlanDePagosEvent.PLAN_APLICAR);
				var objeto:Object = new Object();
				objeto.alumno = view.ddlAlumno.selectedItem;
				objeto.plan = view.ddlPlanDePagos.selectedItem;
				objeto.usuario = commonModel.id_usuario;
				eventAplicarPlan.objeto = objeto;
				dispatchEvent(eventAplicarPlan);
				
			}
		}
		
	}
}