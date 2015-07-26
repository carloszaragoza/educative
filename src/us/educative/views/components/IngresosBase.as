/**
 * Created by carlos on 8/13/14.
 */
package us.educative.views.components {
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.net.navigateToURL;
	
	import mx.controls.Alert;
	import mx.managers.PopUpManager;
	
	import spark.components.Group;
	import spark.components.TitleWindow;
	import spark.events.IndexChangeEvent;
	
	import us.educative.VO.IngresosVO;
	import us.educative.config.EducativeConstants;
	import us.educative.events.IngresosEvent;
	import us.educative.models.CommonModel;
	import us.educative.models.IngresosModel;
	import us.educative.models.NivelEducativoModel;
	import us.educative.models.PeriodoModel;
	import us.educative.views.body.DetalleDePagos;
	
	public class IngresosBase extends Group {
		private var view:Ingresos = Ingresos(this);
		
		[Inject]
		[Bindable] public var periodoModel:PeriodoModel;
		
		[Inject]
		[Bindable] public var nivelEducativoModel:NivelEducativoModel;
		
		[Inject]
		[Bindable] public var ingresosModel:IngresosModel;
		
		[Inject]
		[Bindable] public var commonModel:CommonModel;
		
		public function IngresosBase() {
			super();
		}
		
		public function borrar(data:Object):void
		{
			
		}
		public function modificar(data:Object):void
		{
			
		}
		public function init():void
		{
			//dispatchEvent(new IngresosEvent(IngresosEvent.INGRESOS_TRAE_TODOS_LOS_ALUMNOS));
			
		}
		public function buscarIngresos():void
		{
			
		}
		public function getAllGrupos(event:IndexChangeEvent):void
		{
			if(view.cboNivelEducativo.selectedIndex != -1)
			{
				var eventGrupos:IngresosEvent = new IngresosEvent(IngresosEvent.INGRESOS_GET_ALL_GRUPOS);
				var busqueda:Object = new Object();
				busqueda.id_periodo = periodoModel.cicloVigente.id_periodo;
				busqueda.id_nivel_educativo = view.cboNivelEducativo.selectedItem.id_nivel_educativo;
				eventGrupos.busqueda = busqueda;
				dispatchEvent(eventGrupos);
				var eventConceptos:IngresosEvent = new IngresosEvent(IngresosEvent.INGRESOS_GET_ALL_CONCEPTOS);
				eventConceptos.id_nivel_educativo = view.cboNivelEducativo.selectedItem.id_nivel_educativo;
				dispatchEvent(eventConceptos);
			}
		}
		
		public function getAllAlumnosPorGrupo(event:IndexChangeEvent):void
		{
			var eventAlumnos:IngresosEvent = new IngresosEvent(IngresosEvent.INGRESOS_GET_ALL_ALUMNOS);
			var busqueda:Object = new Object();
			busqueda.id_periodo = periodoModel.cicloVigente.id_periodo;
			busqueda.id_control_inscripcion = view.ddlGrupos.selectedItem.id_control_inscripcion;
			eventAlumnos.busqueda = busqueda;
			dispatchEvent(eventAlumnos);
			
		}
		
		
		public function resetPorcentaje(event:*):void
		{
			//view.txtDescuento.text = "0";
		}
		
		[EventHandler(event="IngresosEvent.INGRESOS_BUSQUEDA_PAGOS")]
		public function traerTodosLosPagosPorAlumno():void
		{
			var eventBuscarPagos:IngresosEvent = new IngresosEvent(IngresosEvent.INGRESOS_TODOS_LOS_PAGOS_DEL_ALUMNO);
			var alumno:Object = new Object();
			alumno.id_control_inscripcion = view.ddlGrupos.selectedItem.id_control_inscripcion;
			alumno.id_alumno = view.ddlAlumnos.selectedItem.alumno_id;
			eventBuscarPagos.alumno = alumno;
			dispatchEvent(eventBuscarPagos);
			
			if(cambio!=0){
				Alert.show("Cambio: $ "+cambio.toString());
			}
			limpiar_cajas();
		}
		
		public function limpiar_cajas():void
		{
			view.checkBoxCondonar.selected = false;
			view.txtRecargos.text = "";
			view.txtBeca.text = "";
			view.txtConcepto.text = "";
			view.txtPorPagar.text = "";
			view.txtPago.text = "";
			view.txtObservaciones.text = "";
			view.txtReferencia.text = "";
			cambio = 0;
		}
		/*Funcion para dicar cuantos días han pasado de la fecha de pago a la actual para aplicar recargos*/
		public function checkRecargo(mes:int, dia:int, porcentaje:int):void
		{
			/*
			Llamar el servicio para listar todos sus conceptos:
			function: traerTodosLosPagosPorAlumno
			**/
			var fechaActual:Date = new Date();
			//verificamos el año si es el del ciclo actual o del nuevo, dependiendo del mes:
			// Si es de Agosto a Diciembre debe ser 2014, si es de Enero a Julio 2015
			//Este año debe debir del ciclo actual, en el año de inicio y el año de termino.
			var year_init:int = Number(String(periodoModel.cicloVigente.fecha_inicial).substr(0,4));
			var year_end:int = Number(String(periodoModel.cicloVigente.fecha_final).substr(0,4));
			var year:int;
			if(mes>=8 && mes <=12){
				year = year_init;
			}else if(mes >=1 && mes<=7){
				year = year_end;
			}
			trace (year);
			var fechaLimite:Date = new Date(year,mes-1, dia);
			//Obtener los dias del mes entre una fecha y otra
			
			
			if(fechaActual.getTime() > fechaLimite.getTime()){
				trace("Hacer recargos");
				var dias_cobrar:Number = Math.floor((new Date().getTime() -
					fechaLimite.getTime()) / (1000 * 60 * 60 * 24))
				if(view.checkBoxCondonar.selected){
					//No se cobran recargos
				}else{
					// Procedimiento para cobrar recargos
					// Es el 10 porciento no importando los dias que pasen.
					var recargo:Number = (EducativeConstants.PORCENTAJE_RECARGO_FIJO * Number(view.ddlConcepto.selectedItem.cantidad_por_pagar))/100;
					view.txtRecargos.text = recargo.toString();
				}
			}else{
				trace("Pago sin recargos")
				view.txtRecargos.text = "0";
			}
			if(view.ddlConcepto.selectedItem == null){
				
			}else{
				var porcentajes:Number = (Number(view.txtDescuento.text)*Number(view.ddlConcepto.selectedItem.cantidad_por_pagar))/100;
				
				// view.txtPorPagar.text = (Number(view.ddlConcepto.selectedItem.precio_publico)-porcentaje).toString();
				if(view.ddlConcepto.selectedItem.aplica_descuento == '1'){
					view.txtBeca.text = porcentajes.toString();	
				}else
				{
					
					view.txtBeca.text = "0";
				}
				
			}
			sumaConceptos();
		}
		
		public function sumaConceptos():void
		{
			if(Number(view.ddlConcepto.selectedItem.restante_a_pagar)<=0){
				view.txtPorPagar.text = "0"
			}else{
				
				if(Number(view.ddlConcepto.selectedItem.cantidad_pagada)==0)
				{
					view.txtPorPagar.text = (Number(view.ddlConcepto.selectedItem.restante_a_pagar) - Number(view.txtBeca.text) + Number(view.txtRecargos.text)).toFixed(2).toString();	
				}else{
					view.txtPorPagar.text = view.ddlConcepto.selectedItem.restante_a_pagar;
				}
			}
			
		}
		
		public function condonarRecargosChange(event:Event):void{
			trace("Perdona recargos");
			if(event.target.selected == true){
				view.txtPorPagar.text = (Number(view.txtPorPagar.text) - Number(view.txtRecargos.text)).toFixed(2).toString();
			}else
			{
				view.txtPorPagar.text = (Number(view.txtPorPagar.text) + Number(view.txtRecargos.text)).toFixed(2).toString();
			}
			
			
		}
		
		public var cambio:Number = 0;
		public function pagarClic():void
		{
			
			//Recogemos todos los datos para enviarlos al controller
			var pago:IngresosVO = new IngresosVO();
			
			pago.m_control_inscripcion_id = view.ddlGrupos.selectedItem.id_control_inscripcion;
			pago.m_alumno_id = view.ddlAlumnos.selectedItem.alumno_id;
			pago.m_producto_servicio_id = view.ddlConcepto.selectedItem.id_producto_servicio;
			if(Number(view.txtDescuento.text) == 0){
				pago.m_descuento = 0;
			}else{
				pago.m_descuento = 1;
			}
			pago.m_tipo_descuento = "%";
			pago.m_cantidad_descuento = Number(view.txtBeca.text);
			pago.d_mes_pago = view.ddlConcepto.selectedItem.mes_de_pago;
			pago.d_fecha_pago = view.txtFechaDePago.text;
			
			if (Number(view.txtPorPagar.text) < Number(view.txtPago.text))
			{
				pago.d_monto_de_pago = Number(view.txtPorPagar.text);
				cambio = Number(view.txtPago.text) - Number(view.txtPorPagar.text);
			}
			else{
				pago.d_monto_de_pago = Number(view.txtPago.text);	
			}
			
			if(Number(view.txtRecargos.text) == 0){
				pago.d_recargo = 0;
			}else{
				pago.d_recargo = 1;
			}
			pago.d_tipo_recargo = "%";
			if(view.checkBoxCondonar.selected){
				//No se cobran recargos
				pago.d_cant_recargo = 0;
			}else{
				pago.d_cant_recargo = Number(view.txtRecargos.text);	
			}
			
			pago.d_referencia  = view.txtReferencia.text;
			pago.d_cuenta_id = 1; // ESTA CUENTA DEBE SER CONFIGURADA COMO LA CUENTA DEFAULT DE INGRESOS.
			pago.d_observaciones = view.txtObservaciones.text;
			pago.m_usuario = commonModel.id_usuario
			pago.id_registro_pago = view.ddlConcepto.selectedItem.id_registro_pago;
			if(view.gpoDepositoBancario.selected) pago.d_metodo_pago = "D";
			if(view.gpoEfectivo.selected) pago.d_metodo_pago = "E";
			if(view.gpoTransferenciaElectronica.selected) pago.d_metodo_pago = "T";
			//caputaro el objeto, vamos a mandarlo al controller por medio de un event.
			pago.por_pagar = Number(view.txtPorPagar.text);
			
			var eventPago:IngresosEvent = new IngresosEvent(IngresosEvent.INGRESOS_PAGO_ALUMNO);
			eventPago.pago = pago;
			dispatchEvent(eventPago);
		}
		
		
		/* concatenarConceptosMes para mostrar un texto*/
		public function concatenarConceptosMes(item:Object):String
		{
			return item.concepto + ' - ' + item.mes_nombre;
		}
		
		public function detalleIngresos(data:Object):void
		{
			//Lanzamos primero el servicio para llenar los detalles de pagos
			var eventDetallesDePago:IngresosEvent = new IngresosEvent(IngresosEvent.INGRESOS_DETALLE_PAGO);
			var objecto:Object = new Object();
			objecto.id_alumno = data.id_alumno;
			objecto.id_producto_servicio = data.id_producto_servicio;
			objecto.mes = data.mes_de_pago;
			eventDetallesDePago.objeto = objecto;
			dispatchEvent(eventDetallesDePago);
			//Abre Popup con grid y lista de registros con opción a borrar un recibo.	
			var detallePagos:DetalleDePagos =  DetalleDePagos(PopUpManager.createPopUp(this,DetalleDePagos, true) as TitleWindow);
			
			PopUpManager.centerPopUp(detallePagos);
			
		}
		public function imprimirRecibo(data:Object):void
		{
			//Manda llamar funcion en PHP para usar librerias de PDF para generar el reporte
			var request:URLRequest = new URLRequest(EducativeConstants.REPORTE);
			
			var variables:URLVariables = new URLVariables();
			variables.id_registro_pago = data.id_registro_pago;
			variables.alumno = data.id_alumno;
			request.data = variables;
			try {            
				navigateToURL(request);
			}
			catch (e:Error) {
				// handle error here
			}
			
		}

        protected function imprimirEstadoDeCuenta():void {
            var request:URLRequest = new URLRequest(EducativeConstants.ESTADO_DE_CUENTA);

            var variables:URLVariables = new URLVariables();
            variables.id_alumno = view.ddlAlumnos.selectedItem.alumno_id;
            variables.id_periodo = view.ddlAlumnos.selectedItem.periodo_id;
            request.data = variables;
            try {
                navigateToURL(request);
            }
            catch (e:Error) {
                // handle error here
				Alert.show(e.message,"Error");
            }
        }
		
	}
}
