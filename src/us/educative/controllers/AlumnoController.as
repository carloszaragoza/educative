package us.educative.controllers
{
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import org.swizframework.controller.AbstractController;
	
	import us.educative.VO.AlumnoVO;
	import us.educative.VO.FileVO;
	import us.educative.events.AlumnoEvent;
	import us.educative.models.AlumnoModel;
	import us.educative.services.AlumnoService;
	import us.educative.views.components.AlumnosBase;
	
	public class AlumnoController extends AbstractController
	{
		[Inject]
		public var alumnoModel:AlumnoModel;
		
		private var alumnoService:AlumnoService = new AlumnoService();
		
		public function AlumnoController()
		{
			super();
		}
		
		private function alumnoFault(event:FaultEvent):void
		{
			Alert.show(event.fault.message, "Error");
		}
		
		[EventHandler(event="AlumnoEvent.ALUMNO_TRY_SAVE", properties="alumno")]
		public function sendAlumnoToService(alumno:AlumnoVO):void
		{
			executeServiceCall(alumnoService.save(alumno),alumnoSaveResult, alumnoFault);
		}
		
		private function alumnoSaveResult(event:ResultEvent):void
		{
			if(event.result.hasOwnProperty('error')){
				Alert.show(event.result.error, "Error");
			}else
			{
				Alert.show("Se guardo correctamente.");
				dispatcher.dispatchEvent(new AlumnoEvent(AlumnoEvent.ALUMNO_CLEAR_CONTROLS));
				
			}
		}
		
		[EventHandler(event="AlumnoEvent.ALUMNO_BUSQUEDA_FILTRADA", properties="textoBusqueda")]
		public function getAllAlumnos(busqueda:String):void
		{
			executeServiceCall(alumnoService.getAll(busqueda), getAllResult, alumnoFault);
		}
		
		private function getAllResult(event:ResultEvent):void
		{
			if(event.result.hasOwnProperty('error')){
				Alert.show(event.result.error, "Error");
			}else{
				alumnoModel.alumnosList = new ArrayCollection(event.result as Array);	
			}
			
		}
		
		[EventHandler(event="AlumnoEvent.ALUMNO_BORRAR", properties="dataGrid")]
		public function deleteAlumno(data:Object):void
		{
			executeServiceCall(alumnoService.deleteById(data.id_alumno), deleteByIdResult, alumnoFault);
		}
		
		private function deleteByIdResult(event:ResultEvent):void
		{
			if(event.result.hasOwnProperty('error')){
				Alert.show(event.result.error, "Error");
			}else{
				Alert.show("Se borro correctamente");
			}
		}
		
		[EventHandler(event="AlumnoEvent.ALUMNO_ACTUALIZAR", properties="alumno")]
		public function updatealumno(alumno:AlumnoVO):void
		{
			executeServiceCall(alumnoService.update(alumno), updateResult, alumnoFault);
		}
		
		private function updateResult(event:ResultEvent):void
		{
			// TODO Auto Generated method stub
			if(event.result.hasOwnProperty('error')){
				Alert.show(event.result.error, "Error");
			}else{
				Alert.show("Se actualizó correctamente");
				dispatcher.dispatchEvent(new AlumnoEvent(AlumnoEvent.ALUMNO_LIMPIAR_FORMULARIO));
			}
		}
		
		[EventHandler(event="AlumnoEvent.ALUMNO_SUBIR_FOTO", properties="fotografia")]
		public function uploadFileToService(fotografia:FileVO):void
		{
			executeServiceCall(alumnoService.uploadFile(fotografia), uploadFileResult, alumnoFault);
		}
		
		private function uploadFileResult(event:ResultEvent):void
		{
			// TODO Auto Generated method stub
			if(event.result)
			{
				//Subio
			}else
			{
				Alert.show("No pudo subir la fotografía en este momento");
			}
		}
		
		
	}
}