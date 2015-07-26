package us.educative.views.components
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.utils.ByteArray;
	
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	import mx.managers.PopUpManager;
	import mx.validators.Validator;
	
	import spark.components.Group;
	import spark.components.TitleWindow;
	
	import us.educative.VO.AlumnoVO;
	import us.educative.VO.FileVO;
	import us.educative.events.AlumnoEvent;
	import us.educative.models.AlumnoModel;
	import us.educative.models.GruposModel;
	import us.educative.views.body.UbicaFamiliar;
	
	public class AlumnosBase extends Group
	{
		//private var view:LoginMenu = LoginMenu(this);
		[Bindable] public var isUpdating:Boolean = false;

        private var view:Alumnos = Alumnos(this);
		
		private var uploadFile:FileReference;
		private var file:FileVO;
		
		
		[Inject]
		[Bindable]
		public var alumnoModel:AlumnoModel;

        [Inject]
        [Bindable]
        public var gruposModel:GruposModel;
		
		public function AlumnosBase()
		{
			super();
		}
		public function ubicarFamiliarPopup():void
		{
			var ubicaFamiliarPopup:UbicaFamiliar = UbicaFamiliar(PopUpManager.createPopUp(this,UbicaFamiliar,true) as TitleWindow);
			
			
			PopUpManager.centerPopUp(ubicaFamiliarPopup);
		}
		public function saveAlumnosSendDataToControllerByEvent(update:Boolean):void
		{
			var errores:Array = Validator.validateAll([view.validaMatricula, view.validaCurp, view.validaNombre, view.validaPaterno,
				view.validaMaterno, view.validaSangre, view.validaEmergencias, view.validaCorreo, view.validaFamilia]);
			if(errores.length == 0)
			{
				var sexoGpo:String;
				if(view.gpoHombre.selected)
				{
					sexoGpo = 'H';
				}else if(view.gpoMujer.selected)
				{
					sexoGpo = 'M';
				}
				
				var alumno:AlumnoVO = new AlumnoVO();
				alumno.sexo = sexoGpo;
				alumno.apaterno = view.txtPaterno.text;
				alumno.amaterno = view.txtMaterno.text;
				alumno.nombre = view.txtNombre.text;
				alumno.fecha_nac = view.dateFechaNacimiento.text;
				alumno.fotografia = view.txtFotografia.text;
				alumno.tel_emergencia = view.txtTelefonoEmergencia.text;
				alumno.alergias = view.txtAlergias.text;
				alumno.enf_precauciones = view.txtEnfermedades.text;
				alumno.curp = view.txtCurp.text;
				alumno.correo_electronico = view.txtCorreo.text;
				alumno.tipo_sangre = view.txtSangre.text;
				alumno.tutor_id = familiaId;
				alumno.id_alumno = idAlumno;
				alumno.matricula = view.txtMatricula.text;
				if(uploadFile){
					uploadFileToServer();
				}
				
				if(update){
					var eventUpdateAlumno:AlumnoEvent = new AlumnoEvent(AlumnoEvent.ALUMNO_ACTUALIZAR);
					
					eventUpdateAlumno.alumno = alumno;
					this.dispatchEvent(eventUpdateAlumno);
				}else{
					var eventSaveAlumno:AlumnoEvent = new AlumnoEvent(AlumnoEvent.ALUMNO_TRY_SAVE);
					eventSaveAlumno.alumno = alumno;
					this.dispatchEvent(eventSaveAlumno);	
				}
			}else
			{
				Alert.show("No puedes continuar hasta corregir los errores");
			}
			
			
		}
		
		private var familiaId:int;
		private var idAlumno:int;
		
		[EventHandler(event="AlumnoEvent.ALUMNO_ENCONTRO_FAMILIA", properties="familia")]
		public function enviarIdFamilia(familiar:Object):void
		{
			view.txtFamilia.text = familiar.familia;
			familiaId = familiar.id_tutor;
		}
		
		protected function buscarTodosLosAlumnos():void
		{
			var eventBuscarAlumnos:AlumnoEvent = new AlumnoEvent(AlumnoEvent.ALUMNO_BUSQUEDA_FILTRADA);
			eventBuscarAlumnos.textoBusqueda = view.txtTextoBusqueda.text;
			dispatchEvent(eventBuscarAlumnos);
		}
		private var objeto:Object;
		public function borrarAlumno(data:Object):void
		{
			objeto =data;
			Alert.show("Estás seguro de borrar el registro?","",3,this,iamShureToDelete);
			
		}
		public function iamShureToDelete(event:CloseEvent):void
		{
			if(event.detail == Alert.YES)
			{
				var eventBorrarAlumno:AlumnoEvent = new AlumnoEvent(AlumnoEvent.ALUMNO_BORRAR);
				eventBorrarAlumno.dataGrid = objeto;
				dispatchEvent(eventBorrarAlumno);
			}
		}
		
		public function modificarAlumno(data:Object):void
		{
			
				view.txtMatricula.text = data.matricula;
				view.txtCurp.text = data.curp;
				view.txtNombre.text = data.nombre;
				view.txtPaterno.text = data.apaterno;
				view.txtMaterno.text = data.amaterno;
				view.txtSangre.text = data.tipo_sangre;
				view.dateFechaNacimiento.text = data.fecha_nac;
				view.txtTelefonoEmergencia.text = data.tel_emergencia;
				view.txtCorreo.text = data.correo_electronico;
				view.txtEnfermedades.text = data.enf_precauciones;
				view.txtFamilia.text = data.familia;
				view.txtAlergias.text = data.alergias;
				familiaId = data.tutor_id;
				idAlumno = data.id_alumno;
				view.imagenFotografia.source = "../upload/"+data.fotografia;
				
				if(data.sexo == 'H')
				{
					view.gpoHombre.selected = true;
					
				}else
				{
					view.gpoMujer.selected = true;
				}
				view.viewStackContenido.selectedIndex = 0;
				isUpdating = true;
				
				view.lblInformacion.text = "Estas actualizando a " +data.nombre + ' ' + data.apaterno + ' ' + data.amaterno;
			
			
		}
		
		[EventHandler(event="AlumnoEvent.ALUMNO_LIMPIAR_FORMULARIO")]
		public function clearControlsByUpdate():void
		{
			clearControls();
			isUpdating = false;
			buscarTodosLosAlumnos();
			
		}
		
		
		[EventHandler(event="AlumnoEvent.ALUMNO_CLEAR_CONTROLS")]
		public function clearControls():void
		{
			view.txtMatricula.text = ""
			view.txtCurp.text = "";
			view.txtNombre.text = "";
			view.txtPaterno.text = "";
			view.txtMaterno.text = "";
			view.txtSangre.text = "";
			view.dateFechaNacimiento.text = "";
			view.txtTelefonoEmergencia.text = "";
			view.txtCorreo.text = "";
			view.txtEnfermedades.text = "";
			view.txtFamilia.text = "";
			view.txtFotografia.text = "";
			view.txtAlergias.text = "";
			familiaId = 0;
			idAlumno = 0;
			isUpdating = false;
			view.imagenFotografia.source = "assets/pics/person.png";
			view.lblInformacion.text = "";
			view.txtMatricula.setFocus();
			
		}
		
		public function newAlumno():void
		{
			clearControls();
		}
		
		public function browersFileToUpload():void
		{
			uploadFile  = new FileReference();
			uploadFile.browse([new FileFilter("Imagenes", "*.jpg;*.gif;*.png")]);
			uploadFile.addEventListener(Event.SELECT,onFileSelect); 
		}
		public function onFileSelect(event:Event):void
		{
			view.txtFotografia.text = uploadFile.name;
			//fileupload.enabled = true;
			// Load the filereference data
			uploadFile.load();
			uploadFile.addEventListener(Event.COMPLETE, onFileLoaded);
			var data:ByteArray = new ByteArray(); 
			
			
			//Read the bytes into bytearray var
			
			
		}
		private function onFileLoaded(e:Event):void
		{
			var loader:Loader = new Loader();
			loader.loadBytes(e.target.data);
			//addChild(loader);
			view.imagenFotografia.source = loader.content;
			
		}
		
		public function uploadFileToServer():void {
			
			var data:ByteArray = new ByteArray(); 
			if(uploadFile){
				//Read the bytes into bytearray var
				uploadFile.data.readBytes(data, 0, uploadFile.data.length); 
				
				// Create a new FileVO instance
				file = new FileVO();
				file.filename = uploadFile.name;
				file.filedata = data;
				
				//service.upload(file);
				var eventFotografiaAlumno:AlumnoEvent = new AlumnoEvent(AlumnoEvent.ALUMNO_SUBIR_FOTO);
				eventFotografiaAlumno.fotografia = file;
				dispatchEvent(eventFotografiaAlumno);
			}
			
			
		}

        public function asignarGrupo(data:Object):void
        {

        }
			
	}
}