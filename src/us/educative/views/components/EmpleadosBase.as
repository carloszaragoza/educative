package us.educative.views.components
{
	import mx.collections.IViewCursor;
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	import mx.utils.object_proxy;
	import mx.validators.Validator;
	
	import spark.collections.Sort;
	import spark.collections.SortField;
	import spark.components.Group;
	
	import us.educative.VO.EmpleadoVO;
	import us.educative.events.EmpleadoEvent;
	import us.educative.models.CommonModel;
	import us.educative.models.EmpleadoModel;
	
	public class EmpleadosBase extends Group
	{
		private var view:Empleados = Empleados(this);
		
		[Bindable] public var isUpdating:Boolean = false;
		
		[Inject]
		[Bindable] public var commonModel:CommonModel;
		
		[Inject]
		[Bindable] public var empleadoModel:EmpleadoModel;
		
		private var objeto:Object;
		
		public function EmpleadosBase()
		{
			super();
		}
		
		public function saveSendDataToControllerByEvent(update:Boolean):void
		{
			var errores:Array = Validator.validateAll([view.validaRFC, view.validaNombre, view.validaPaterno, view.validaMaterno, view.validaDireccion, view.validaCP,
				view.validaTelefono, view.validaCelular, view.validaCorreo]);
			if(errores.length == 0 && view.cboEstudios.selectedIndex != -1 && view.cboPerfil.selectedIndex != -1)
			{
				var empleado:EmpleadoVO = new EmpleadoVO();
				empleado.rfc_empleado = view.txtRFC.text;
				empleado.nombre = view.txtNombre.text;
				empleado.paterno = view.txtPaterno.text;
				empleado.materno = view.txtMaterno.text;
				empleado.fecha_nacimiento = view.dateFieldNacimiento.text;
				empleado.direccion = view.txtDireccion.text;
				empleado.cp = view.txtCP.text;
				empleado.celular = view.txtCelular.text;
				empleado.telefono_fijo = view.txtTelefono.text;
				empleado.correo = view.txtCorreo.text;
				empleado.perfil_id = view.cboPerfil.selectedItem.id_perfil;
				empleado.grado_maximo_estudio = view.cboEstudios.selectedItem.label;
				empleado.horas_semana =view.nsHorasSemana.value;
				empleado.observaciones = view.txtObservaciones.text;
				empleado.NSS = view.txtNSS.text;
				if(isUpdating){
					empleado.id_empleado=idEmpleado;
					var eventEmpleadoUpdate:EmpleadoEvent = new EmpleadoEvent(EmpleadoEvent.EMPLEADO_UPDATE);
					eventEmpleadoUpdate.empleado = empleado;
					dispatchEvent(eventEmpleadoUpdate);
				}else{
					
					var eventEmpleadoSave:EmpleadoEvent = new EmpleadoEvent(EmpleadoEvent.EMPLEADO_GUARDAR);
					eventEmpleadoSave.empleado = empleado;
					dispatchEvent(eventEmpleadoSave);	
				}
			}else
			{
				Alert.show("Existen errores, por favor revisa");
			}
			
			
		}
		
		[EventHandler(event="EmpleadoEvent.EMPLEADO_LIMPIA_FORMULARIO")]
		public function clearControls():void
		{
			view.txtRFC.text = "";
			view.txtNombre.text = "";
			view.txtPaterno.text = "";
			view.txtMaterno.text = "";
			view.txtTelefono.text = "";
			view.txtCorreo.text = "";
			view.dateFieldNacimiento.text = "";
			view.txtDireccion.text = "";
			view.txtCP.text = "";
			view.txtCelular.text = "";
			view.txtTelefono.text = "";
			view.txtObservaciones.text = "";
			view.txtNSS.text = "";
			view.cboEstudios.selectedIndex = -1;
			view.cboPerfil.selectedIndex = -1;
			isUpdating = false;
			view.txtRFC.setFocus();
			view.lblInformacion.text = "";
		}
		[EventHandler(event="EmpleadoEvent.EMPLEADO_LIMPIA_FORMULARIO_UPDATE")]
		public function clearControlsByUpdate():void
		{
			clearControls();
			isUpdating = false;
			buscarClick();
			
		}
		[EventHandler(event="EmpleadoEvent.EMPLEADO_VISTA_BUSCA")]
		public function buscarClick():void
		{
			var eventBusqueda:EmpleadoEvent = new EmpleadoEvent(EmpleadoEvent.EMPLEADO_BUSQUEDA_POR_FILTRO);
			eventBusqueda.busqueda = view.txtBusqueda.text;
			dispatchEvent(eventBusqueda);
		}
			
		public function borrarEmpleado(data:Object):void
		{
			objeto = data;
			Alert.show("Estás seguro de borrar el registro?","",3,this,iamShureToDelete);

		}
		public function iamShureToDelete(event:CloseEvent):void
		{
			if(event.detail == Alert.YES)
			{
				var eventBorrarEmpleado:EmpleadoEvent = new EmpleadoEvent(EmpleadoEvent.EMPLEADO_DELETE);
				eventBorrarEmpleado.objeto = objeto;
				dispatchEvent(eventBorrarEmpleado);
			}
		}
		private var cursorPerfil:IViewCursor;
		private var cursorEducacion:IViewCursor;
		
		public function modificarEmpleado(data:Object):void
		{
			view.txtRFC.text = data.rfc_empleado;
			view.txtNombre.text = data.nombre;
			view.txtPaterno.text = data.paterno;
			view.txtMaterno.text = data.materno;
			view.txtTelefono.text = data.telefono_fijo;
			view.txtCorreo.text = data.correo;
			view.dateFieldNacimiento.text = data.fecha_nacimiento;
			view.txtDireccion.text = data.direccion;
			view.txtCP.text = data.cp;
			view.txtCelular.text = data.celular;
			view.txtObservaciones.text = data.observaciones;
			view.txtNSS.text = data.NSS;
			doSort('id_perfil',commonModel.perfilesList);
			cursorPerfil = commonModel.perfilesList.createCursor();
			cursorEducacion = commonModel.estudiosList.createCursor();
			
			var dato:Object = new Object();
			dato.id_perfil  = data.perfil_id;
			var datoestudio:Object = new Object();
			datoestudio.label = data.grado_maximo_estudio;
			
			var found:Boolean = cursorPerfil.findAny(dato);
			if(found){
				view.cboPerfil.selectedItem = cursorPerfil.current;
			}
			doSort('label', commonModel.estudiosList);
			var foundEstudios:Boolean = cursorEducacion.findAny(datoestudio);
			if(foundEstudios){
				view.cboEstudios.selectedItem = cursorEducacion.current;
			}
			view.viewStackContenido.selectedIndex = 0;
			idEmpleado = data.id_empleado;
			isUpdating = true;
			
			view.lblInformacion.text = "Estas actualizando a "+data.nombre+' '+data.paterno+' '+data.materno;
		}
		[Bindable] private var idEmpleado:int;
		private function doSort(campo:String, arreglo:*):void{
			var sf:SortField = new SortField(campo);
			var s:Sort = new Sort();
			s.fields = [sf];
			arreglo.sort = s;
			arreglo.refresh();
		}
	}
}