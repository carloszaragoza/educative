package us.educative.views.components
{
	import mx.collections.ArrayCollection;
	import mx.collections.IViewCursor;
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	import mx.managers.ICursorManager;
	
	import spark.collections.Sort;
	import spark.collections.SortField;
	import spark.components.Group;
	
	import us.educative.VO.ServiciosProductosVO;
	import us.educative.events.ServiciosProductosEvent;
	import us.educative.models.NivelEducativoModel;
	import us.educative.models.PeriodoModel;
	import us.educative.models.ServiciosProductosModel;
	
	public class ServiciosProductosBase extends Group
	{
		[Inject]
		[Bindable] public var serviciosProductosModel:ServiciosProductosModel;
		
		[Inject]
		[Bindable] public var periodoModel:PeriodoModel;
		
		[Inject]
		[Bindable] public var nivelEducativoModel:NivelEducativoModel;
		
		[Bindable]
		public var isUpdating:Boolean = false;
		
		/* Recupera el dato al momento de actualizar un servicio */
		[Bindable] public var idPago:int;
		
		[Bindable] public var acTipo:ArrayCollection = new ArrayCollection([{tipo:'Servicio', tipo_pago:'S'},{tipo:'Producto', tipo_pago:'P'}]);
		
		private var view:ServiciosProductos = ServiciosProductos(this);
		
		public function ServiciosProductosBase()
		{
			super();
		}
		public function clickHandlerPagos(updated:Boolean):void
		{
			var pagos:ServiciosProductosVO = new ServiciosProductosVO();
			if(view.gpoProducto.selected){
				pagos.tipo_concepto = 'P';
			}else
			{
				pagos.tipo_concepto = 'S';
			}
			pagos.clave = view.txtClave.text;
			pagos.concepto = view.txtConcepto.text;
			pagos.periodo_id = 2;
			pagos.nivel_educativo_id = view.cboNivelEducativo.selectedItem.id_nivel_educativo;
			pagos.precio_general = Number(view.txtPrecioGeneral.text);
			pagos.precio_publico = Number(view.txtPrecioPublico.text);
			pagos.aplica_descuento = int(view.checkBoxDescuento.selected);
			pagos.aplica_recargo = int(view.checkBoxRecargo.selected);
			pagos.aplica_impuesto = int(view.checkBoxImpuesto.selected);
			pagos.facturable = int(view.checkBoxFacturable.selected);
			pagos.pago_unico = int(view.checkBoxPagoUnico.selected);
			if(view.checkBoxPagoUnico.selected){
				pagos.numero_pagos = 0;
			}else{
				pagos.numero_pagos = view.numericStepperNumeroDePagos.value;
			}
			pagos.observaciones = view.txtObservaciones.text;
			if(updated){
				pagos.id_producto_servicio = idPago;
				var eventActualizarPagoCatalogo:ServiciosProductosEvent = new ServiciosProductosEvent(ServiciosProductosEvent.SERVICIOS_PRODUCTOS_ACTUALIZAR);
				eventActualizarPagoCatalogo.serviciosProductos = pagos;
				dispatchEvent(eventActualizarPagoCatalogo);
			}else{
				var eventGuardarPagoCatalogo:ServiciosProductosEvent = new ServiciosProductosEvent(ServiciosProductosEvent.SERVICIOS_PRODUCTOS_GUARDAR);
				eventGuardarPagoCatalogo.serviciosProductos = pagos;
				dispatchEvent(eventGuardarPagoCatalogo);
			}
		}
		
		public function modificar(data:Object):void
		{
			view.txtClave.text = data.clave;
			view.txtConcepto.text = data.concepto;
			view.txtPrecioGeneral.text = data.precio_general;
			view.txtPrecioPublico.text = data.precio_publico;
			if(data.tipo_pago == 'S'){
				view.gpoServicio.selected = true;
			}else if(data.tipo_pago == 'P')
			{
				view.gpoProducto.selected = true;
			}
			if(data.aplica_descuento == 1) view.checkBoxDescuento.selected = true;
			else view.checkBoxDescuento.selected = false;
			if(data.aplica_recargo == 1 ) view.checkBoxRecargo.selected = true;
			else view.checkBoxRecargo.selected = false;
			if(data.impuesto == 1) view.checkBoxImpuesto.selected = true;
			else view.checkBoxImpuesto.selected = false;
			if(data.facturable == 1) view.checkBoxFacturable.selected = true;
			else view.checkBoxFacturable.selected = false;
			if(data.pago_unico == 1) view.checkBoxPagoUnico.selected = true;
			else view.checkBoxPagoUnico.selected = false;

            view.gpoProducto.enabled = false;
            view.gpoServicio.enabled = false;

			if(data.pago_unico == 1){
				view.hgPagos.visible = false;
			}
			view.txtObservaciones.text = data.observaciones;
			doSort('nivel', nivelEducativoModel.nivelEducativoList);
			var cursorTipo:IViewCursor;
			cursorTipo = nivelEducativoModel.nivelEducativoList.createCursor();
			var found:Boolean = cursorTipo.findAny(data);
			if(found)
			{
				view.cboNivelEducativo.selectedItem = cursorTipo.current;
			}
			
			view.numericStepperNumeroDePagos.value = int(data.numero_pagos);
			isUpdating = true;
			idPago = data.id_producto_servicio;
			view.viewStackContenido.selectedIndex =0;
			
		}
		
		private function doSort(campo:String, arreglo:*):void{
			var sf:SortField = new SortField(campo);
			var s:Sort = new Sort();
			s.fields = [sf];
			arreglo.sort = s;
			arreglo.refresh();
		}
		
		private var objeto:Object;
		public function borrar(data:Object):void
		{
			objeto =data;
			Alert.show("Estás seguro de borrar el registro?","",3,this,iamShureToDelete);
		}
		
		public function iamShureToDelete(event:CloseEvent):void
		{
			if(event.detail == Alert.YES)
			{
				var eventBorrar:ServiciosProductosEvent = new ServiciosProductosEvent(ServiciosProductosEvent.SERVICIOS_PRODUCTOS_BORRAR);
				eventBorrar.datagrid = objeto;
				dispatchEvent(eventBorrar);
			}
		}
		
		
		public function buscarPorFiltro():void
		{
			var eventBuscarPorFiltro:ServiciosProductosEvent = new ServiciosProductosEvent(ServiciosProductosEvent.SERVICIOS_PRODUCTOS_GET_BY_FILTER);
			var objeto:Object = new Object();
			objeto.tipo = view.ddlTipoServicio.selectedItem.tipo_pago;
			objeto.texto = view.txtBusqueda.text;
			eventBuscarPorFiltro.busquedObjeto = objeto;
			dispatchEvent(eventBuscarPorFiltro);
		}
		
		
		[EventHandler(event="ServiciosProductosEvent.SERVICIOS_PRODUCTOS_LIMPIA_FORMULARIO_UPDATE")]
		public function clearControlsByUpdate():void
		{
			clearControls();
			//buscarPadresClick();
			
		}
		
		
		[EventHandler(event="ServiciosProductosEvent.SERVICIOS_PRODUCTOS_LIMPIA_FORMULARIO")]
		public function clearControls():void
		{
			view.txtClave.text = "";
			view.txtConcepto.text = "";
			view.txtPrecioGeneral.text = "";
			view.txtPrecioPublico.text = "";
			view.numericStepperNumeroDePagos.value = 1;
			view.gpoServicio.selected = false;
			view.gpoProducto.selected = false;
			
			view.checkBoxDescuento.selected = false;
			view.checkBoxRecargo.selected = false;
			view.checkBoxImpuesto.selected = false;
			view.checkBoxFacturable.selected = false;
			view.checkBoxPagoUnico.selected = false;
			
			view.txtObservaciones.text = "";
			view.lblInformacion.text = "";
			view.txtClave.setFocus();
			isUpdating = false;
            view.gpoProducto.enabled = true;
            view.gpoServicio.enabled = true;
			
			
		}
		
		
		
	}
}