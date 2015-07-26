package us.educative.views.components
{
	import mx.collections.IViewCursor;
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	import mx.validators.Validator;
	
	import spark.collections.Sort;
	import spark.collections.SortField;
	import spark.components.Group;
	
	import us.educative.VO.PeriodoVO;
	import us.educative.events.PeriodoEvent;
	import us.educative.models.CommonModel;
	import us.educative.models.PeriodoModel;
	
	public class PeriodosBase extends Group
	{
		
		[Inject]
		[Bindable] public var commonModel:CommonModel;
		private var view:Periodos = Periodos(this);
		
		[Inject]
		[Bindable] public var periodoModel:PeriodoModel;
		
		[Bindable] public var isUpdating:Boolean = false;
		private var id_periodo:int;
		public function PeriodosBase()
		{
			super();
		}
		
		public function saveSendDataToControllerByEvent(update:Boolean):void
		{
			var errores:Array = Validator.validateAll([view.validaNombre, view.validaFechaInicial, view.validaFechaFinal]);
			if (errores.length == 0){
				var periodo:PeriodoVO = new PeriodoVO();
				periodo.tipo_periodo = view.cboPeriodos.selectedItem.label;
				periodo.nombre = view.txtNombre.text;
				periodo.fecha_inicial = view.dateChooserInicial.text;
				periodo.fecha_final = view.dateChooserFinal.text;
				if(update){
					periodo.id_periodo = idPeriodo;
					var eventUpdatePeriodo:PeriodoEvent = new PeriodoEvent(PeriodoEvent.PERIODO_UPDATE);	
					eventUpdatePeriodo.periodo = periodo;
					dispatchEvent(eventUpdatePeriodo);
				}else
				{
					var eventSavePeriodo:PeriodoEvent = new PeriodoEvent(PeriodoEvent.PERIODO_SAVE);
					eventSavePeriodo.periodo = periodo;
					dispatchEvent(eventSavePeriodo);
				}
			}else{
				Alert.show("Faltan datos por llenar", "Campos");
			}
			
		}
		public function modificarPeriodo(data:Object):void
		{
			view.txtNombre.text = data.nombre;
			view.dateChooserInicial.text = data.fecha_inicial;
			view.dateChooserFinal.text = data.fecha_final;
			var dato:Object = new Object();
			dato.label  = data.tipo_periodo;
			doSort('label', commonModel.periodosList);
			
			cursorPeriodo = commonModel.periodosList.createCursor();
			var found:Boolean = cursorPeriodo.findAny(dato);
			if(found){
				view.cboPeriodos.selectedItem = cursorPeriodo.current;
			}
			view.viewStackContenido.selectedIndex = 0;
			idPeriodo = data.id_periodo;
			isUpdating = true;
			
			view.lblInformacion.text = "Estas actualizando el periodo: " + data.nombre;
			
		}
		private var cursorPeriodo:IViewCursor;
		[Bindable] private var idPeriodo:int;
		private function doSort(campo:String, arreglo:*):void{
			var sf:SortField = new SortField(campo);
			var s:Sort = new Sort();
			s.fields = [sf];
			arreglo.sort = s;
			arreglo.refresh();
		}
		private var objeto:Object;
		public function borrarPeriodo(data:Object):void
		{
			objeto =data;
			Alert.show("Estás seguro de borrar el registro?","",3,this,iamShureToDelete);
		}
		public function iamShureToDelete(event:CloseEvent):void
		{
			if(event.detail == Alert.YES)
			{
				var eventBorrar:PeriodoEvent = new PeriodoEvent(PeriodoEvent.PERIODO_DELETE);
				eventBorrar.datagrid = objeto;
				dispatchEvent(eventBorrar);
			}
		}
		
		[EventHandler(event="PeriodoEvent.PERIODO_LIMPIA_FORMULARIO")]
		public function clearControls():void
		{
			view.cboPeriodos.selectedIndex = -1;
			view.txtNombre.text = "";
			view.dateChooserInicial.text="";
			view.dateChooserFinal.text="";
			view.txtNombre.setFocus();
			view.lblInformacion.text = "";
		}
		
		[EventHandler(event="PeriodoEvent.PERIODO_LIMPIA_FORMULARIO_UPDATE")]
		public function clearControlsByUpdate():void
		{
			clearControls();
			isUpdating = false;
			buscarClick();
			
		}
		
		[EventHandler(event="PeriodoEvent.PERIODO_VISTA_BUSCA")]
		public function buscarClick():void
		{
			var eventBusqueda:PeriodoEvent = new PeriodoEvent(PeriodoEvent.PERIODO_BUSQUEDA_POR_FILTRO);
			eventBusqueda.busqueda = view.txtBusqueda.text;
			dispatchEvent(eventBusqueda);
		}
	}
}