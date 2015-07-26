package us.educative.views.components
{
	import mx.collections.IViewCursor;
	import mx.collections.Sort;
	import mx.collections.SortField;
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	import mx.validators.Validator;
	
	import spark.components.Group;
	import spark.events.IndexChangeEvent;
	
	import us.educative.VO.FamiliaVO;
	import us.educative.VO.LocalidadVO;
	import us.educative.VO.MunicipioVO;
	import us.educative.events.DireccionEvent;
	import us.educative.events.PadresEvent;
	import us.educative.models.CommonModel;
	import us.educative.models.DireccionModel;
	import us.educative.models.PadresModel;
	
	public class PadresBase extends Group
	{
		[Inject]
		[Bindable]
		public var direccionModel:DireccionModel;
	
		[Inject]
		[Bindable]
		public var padresModel:PadresModel;
		
		private var objeto:Object;
		private var view:Padres = Padres(this);
		[Bindable]
		public var isUpdating:Boolean = false;
		public var id_tutorActulizar:int;
		private var entidadSeleccionada:String;
		private var municipioSeleccionado:String;
		private var cursorMunicipio:IViewCursor;
		private var cursorLocalidad:IViewCursor;
		
		public function PadresBase()
		{
			super();
		}
		public function guardarFamiliaClick(isUpdate:Boolean):void
		{
			var errores:Array = Validator.validateAll([view.validaNombre, view.validaPaterno, view.validaMaterno, view.validaTelefono, view.validaCorreo,
				view.validaNombreMama, view.validaPaternoMama, view.validaMaternoMama, view.validaTelefonoMama, view.validaCorreoMama,
				view.validaFamilia, view.validaDireccion, view.validaCP]);
			if(errores.length==0 && view.cboEntidad.selectedIndex != -1 && view.cboMunicipio.selectedIndex != -1 && view.cboLocalidad.selectedIndex != -1)
			{
				var familia:FamiliaVO = new FamiliaVO();
				familia.p_nombre = view.txtNombre.text;	
				familia.p_paterno = view.txtPaterno.text;	
				familia.p_materno = view.txtMaterno.text;	
				familia.p_telefono = view.txtTelefono.text;	
				familia.p_correo = view.txtCorreo.text;	
				familia.m_nombre = view.txtNombreMama.text;	
				familia.m_paterno = view.txtPaternoMama.text;	
				familia.m_materno = view.txtMaternoMama.text;	
				familia.m_telefono = view.txtTelefonoMama.text;	
				familia.m_correo = view.txtCorreoMama.text;
				familia.direccion = view.txtDireccion.text;
				familia.cp = view.txtCP.text;
				familia.localidad_id = view.cboLocalidad.selectedItem.id_localidad;
				familia.municipio_id = view.cboMunicipio.selectedItem.id_municipio;
				familia.entidad_id = view.cboEntidad.selectedItem.id_entidad;
				familia.familia = view.txtFamilia.text;
				
				if(isUpdate){
					familia.id_tutor = id_tutorActulizar;
					var eventFamiliaUpdate:PadresEvent = new PadresEvent(PadresEvent.PADRES_UPDATE);
					eventFamiliaUpdate.familia = familia;
					dispatchEvent(eventFamiliaUpdate);
				}else{
					var eventFamiliaSave:PadresEvent = new PadresEvent(PadresEvent.PADRES_SAVE);
					eventFamiliaSave.familia = familia;
					dispatchEvent(eventFamiliaSave);
				}
			}else{
				Alert.show("Existen errores, revisa y corrige por favor");
			}
			
			
				
		}
		
		public function changeComboEntidad(event:IndexChangeEvent):void
		{
			entidadSeleccionada = event.target.selectedItem['id_entidad'];
			// TODO Auto-generated method stub
			var eventMunicipio:DireccionEvent = new DireccionEvent(DireccionEvent.MUNICIPIO_LIST_DATA);
			var mpio:MunicipioVO = new MunicipioVO();
			mpio.idEntidad = entidadSeleccionada
			eventMunicipio.municipioVO = mpio;
			dispatchEvent(eventMunicipio);
		}
		
		public function changeComboMunicipio(event:IndexChangeEvent):void
		{
			municipioSeleccionado = event.target.selectedItem['id_municipio'];
			// TODO Auto-generated method stub
			var eventLocalidad:DireccionEvent =  new DireccionEvent(DireccionEvent.LOCALIDAD_LIST_DATA);
			var localidad:LocalidadVO = new LocalidadVO();
			localidad.idEntidad = entidadSeleccionada;
			localidad.idMunicipio = municipioSeleccionado;
			eventLocalidad.localidadVO = localidad;
			dispatchEvent(eventLocalidad);
		}
		
		public function buscarPadresClick():void
		{
			var eventPadresBusqueda:PadresEvent = new PadresEvent(PadresEvent.PADRES_BUSQUEDA_POR_FILTRO);
			eventPadresBusqueda.busqueda = view.txtBusqueda.text;
			dispatchEvent(eventPadresBusqueda);
		}
		
		public function borrarFamilia(data:Object):void
		{
			objeto =data;
			Alert.show("Estás seguro de borrar el registro?","",3,this,iamShureToDelete);
		}
		public function iamShureToDelete(event:CloseEvent):void
		{
			if(event.detail == Alert.YES)
			{
				var eventBorrarFamilia:PadresEvent = new PadresEvent(PadresEvent.PADRES_DELETE);
				eventBorrarFamilia.datagrid = objeto;
				dispatchEvent(eventBorrarFamilia);
			}
		}
		public var cursorEntidad:IViewCursor;
		
		public function modificarFamilia(data:Object):void
		{
			view.txtNombre.text = data.p_nombre;
			view.txtPaterno.text = data.p_paterno;
			view.txtMaterno.text = data.p_materno;
			view.txtTelefono.text = data.p_telefono;
			view.txtCorreo.text = data.p_correo;
			view.txtNombreMama.text = data.m_nombre;
			view.txtPaternoMama.text = data.m_paterno;
			view.txtMaternoMama.text = data.m_materno;
			view.txtTelefonoMama.text = data.m_telefono;
			view.txtCorreoMama.text = data.m_correo;
			view.txtDireccion.text = data.direccion;
			view.txtCP.text = data.cp;
			//Viene localidad, municipio y entidad.
			doSort('id_entidad',direccionModel.acListEntidad);
			cursorEntidad = direccionModel.acListEntidad.createCursor();
			
			dato.id_entidad = data.entidad_id;
			dato.id_municipio = data.municipio_id;
			dato.id_localidad = data.localidad_id;
			var found:Boolean = cursorEntidad.findAny(dato);
			if (found)
			{
				view.cboEntidad.selectedItem = cursorEntidad.current;
				trace()
				var changeEvent:IndexChangeEvent = new IndexChangeEvent(IndexChangeEvent.CHANGE);
				view.cboEntidad.dispatchEvent(changeEvent);
				direccionModel.entidadLocated = true;
			}
			view.txtCP.text = data.cp;
			view.txtFamilia.text =data.familia;
			
			view.viewStackContenido.selectedIndex = 0;
			isUpdating = true;
			id_tutorActulizar = data.id_tutor;
			view.lblInformacion.text = "Estas actualizando a " + data.p_nombre + ' ' + data.p_paterno;
		}
		
		private function doSort(campo:String, arreglo:*):void{
			var sf:SortField = new SortField(campo);
			var s:Sort = new Sort();
			s.fields = [sf];
			arreglo.sort = s;
			arreglo.refresh();
		}
		[Bindable] private var dato:Object = new Object();
		[EventHandler(event="DireccionEvent.LOCALIZA_MUNICIPIO")] //localizamos evento cuando es de update
		public function filterMunicipios(event:DireccionEvent):void
		{
			doSort('id_municipio', direccionModel.acListMunicipio);
			cursorMunicipio = direccionModel.acListMunicipio.createCursor();
			var found:Boolean = cursorMunicipio.findAny(dato);
			//var foundMpio:Boolean = cursorMunicipio.findAny(event.obraVO);
			if (found)
			{
				view.cboMunicipio.selectedItem = cursorMunicipio.current;
				var changeEvent:IndexChangeEvent = new IndexChangeEvent(IndexChangeEvent.CHANGE);
				view.cboMunicipio.dispatchEvent(changeEvent);
				direccionModel.municipioLocated = true;
				
			}
		}
		
		[EventHandler(event="DireccionEvent.LOCALIZA_LOCALIDAD")] //localizamos evento cuando es de update
		public function filterlocalidad(event:DireccionEvent):void
		{
			doSort('id_localidad', direccionModel.acListLocalidad);
			cursorLocalidad = direccionModel.acListLocalidad.createCursor();
			var found:Boolean = cursorLocalidad.findAny(dato);
			//var foundMpio:Boolean = cursorMunicipio.findAny(event.obraVO);
			if (found)
			{
				view.cboLocalidad.selectedItem = cursorLocalidad.current;
				
			}
		}
		
		[EventHandler(event="PadresEvent.PADRES_LIMPIA_FORMULARIO_UPDATE")]
		public function clearControlsByUpdate():void
		{
			clearControls();
			buscarPadresClick();
			
		}
		
		
		[EventHandler(event="PadresEvent.PADRES_LIMPIA_FORMULARIO")]
		public function clearControls():void
		{
			view.txtNombre.text = "";
			view.txtPaterno.text = "";
			view.txtMaterno.text = "";
			view.txtTelefono.text = "";
			view.txtCorreo.text = "";
			view.txtNombreMama.text = "";
			view.txtPaternoMama.text = "";
			view.txtMaternoMama.text = "";
			view.txtTelefonoMama.text = "";
			view.txtCorreoMama.text = "";
			view.txtDireccion.text = "";
			view.txtCP.text = "";
			view.cboEntidad.selectedIndex = 12;
			view.cboMunicipio.selectedIndex = -1;
			view.cboLocalidad.selectedIndex = -1;
			view.lblInformacion.text = "";
			view.txtNombre.setFocus();
			isUpdating = false;
		}
		
	}
}