package us.educative.controllers
{
	import mx.collections.ArrayCollection;
	import mx.containers.ControlBar;
	import mx.controls.Alert;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import org.swizframework.controller.AbstractController;
	
	import us.educative.VO.ControlInscripcionVO;
	import us.educative.events.GruposEvent;
	import us.educative.models.CommonModel;
	import us.educative.models.GruposModel;
	import us.educative.services.GruposService;
	
	public class GruposController extends AbstractController
	{
		[Inject]
		public var gruposModel:GruposModel = new GruposModel()

		private var gruposService:GruposService = new GruposService();

        [Inject]
        public var commonModel:CommonModel = new CommonModel();

        public function GruposController()
		{
			super();
		}
		
		[EventHandler(event="GruposEvent.GRUPOS_GET_ALL")]
		public function getAllController():void
		{
			executeServiceCall(gruposService.getAll(), getAllResult, gruposFault);
		}
		
		private function getAllResult(event:ResultEvent):void
		{
			// TODO Auto Generated method stub
			if(event.result.hasOwnProperty('error')){
				Alert.show(event.result.error, "Error");
			}else
			{
				gruposModel.gruposAllList = new ArrayCollection(event.result as Array);
			}
		}
		
		private function gruposFault(event:FaultEvent):void
		{
			// TODO Auto Generated method stub
			Alert.show(event.fault.message);
		}
        [EventHandler(event="GruposEvent.GRUPOS_BUSCAR_PERIODOS", properties="controlInscripcion")]
        public function buscarPeriodosController(control:ControlInscripcionVO):void
        {
            executeServiceCall(gruposService.getGruposByPeriodosGrupos(control), getGruposByPeriodosGruposResult, gruposFault);
        }

        private function getGruposByPeriodosGruposResult(event:ResultEvent):void
        {
            if(event.result.hasOwnProperty('error')){
                Alert.show(event.result.error, "Error");
            }else{
                gruposModel.gruposList = new ArrayCollection(event.result as Array);
            }
        }

        [EventHandler(event="GruposEvent.GRUPOS_GUARDAR", properties="controlInscripcion")]
        public function guardarGrupoInscripcion(control:ControlInscripcionVO):void
        {
            executeServiceCall(gruposService.saveGrupo(control), saveGrupoResult, gruposFault);
        }

        private function saveGrupoResult(event:ResultEvent):void {
            if(event.result.hasOwnProperty('error')){
                Alert.show(event.result.error, "Error");
            }else{
                if(event.result){
                    Alert.show("Se guardo correctamente");
                    dispatcher.dispatchEvent(new GruposEvent(GruposEvent.GRUPOS_LIMPIAR_FORMULARIO));
                }
            }
        }

        [EventHandler(event="GruposEvent.GRUPOS_ACTUALIZAR", properties="controlInscripcion")]
        public function actualizar(control:ControlInscripcionVO):void
        {
            executeServiceCall(gruposService.actualizar(control), actualizarResult, gruposFault);
        }

        private function actualizarResult(event:ResultEvent):void {
            if(event.result.hasOwnProperty('error')){
                Alert.show(event.result.error, "Error");
            }else{
                Alert.show("Se actualizó correctamente");
                dispatcher.dispatchEvent(new GruposEvent(GruposEvent.GRUPOS_LIMPIAR_FORMULARIO_AFTER_UPDATE));
            }
        }

        [EventHandler(event="GruposEvent.GRUPOS_BORRAR", properties="datagrid")]
        public function borrar(datagrid:Object):void
        {
            executeServiceCall(gruposService.borrar(datagrid), borrarResult, gruposFault);
        }


        private function borrarResult(event:ResultEvent):void {
            if(event.result.hasOwnProperty('error')){
                Alert.show(event.result.error, "Error");
            }else{
                Alert.show("Se borro correctamente");
                dispatcher.dispatchEvent(new GruposEvent(GruposEvent.GRUPOS_BORRADOS));
            }
        }

        [EventHandler(event="GruposEvent.GRUPOS_INSCRIBIR_ALUMNO", properties="alumno")]
        public function inscribirAlumno(alumno:Object):void
        {
            executeServiceCall(gruposService.inscribirAlumno(alumno), inscribirAlumnoResult, gruposFault);
        }


        public function inscribirAlumnoResult(event:ResultEvent):void {
            if(event.result.hasOwnProperty('error')){
                Alert.show(event.result.error, "Error");
            }else{
                //Disparamos evento para refrescar o agregar el alumno al grid del grupo
                dispatcher.dispatchEvent(new GruposEvent(GruposEvent.GRUPOS_LANZAR_BUSQUEDA_DESDE_VISTA));
                dispatcher.dispatchEvent(new GruposEvent(GruposEvent.GRUPOS_BUSCAR_ALUMNO));
				//dispatcher.dispatchEvent(new GruposEvent(GruposEvent.GRUPOS_CARGAR_PLAN_DE_PAGOS));
            }
        }

        [EventHandler(event="GruposEvent.GRUPOS_REFRESCAR_INSCRITOS", properties="controlInscripcion")]
        public function refrescarGrupo(control:ControlInscripcionVO):void
        {
            executeServiceCall(gruposService.refrescarGrupos(control), refrescarGruposResult, gruposFault);
        }

        private function refrescarGruposResult(event:ResultEvent):void {
            if(event.result.hasOwnProperty('error')){
                Alert.show(event.result.error, "Error");
            }else{
                //envia la lista en el modelo
                gruposModel.alumnosGrupoList = new ArrayCollection(event.result as Array);
            }
        }
        [EventHandler(event="GruposEvent.GRUPOS_BUSCAR_LOS_NO_INSCRITOS", properties="busqueda, ciclo")]
        public function alumnosNoInscritos(busqueda:String, ciclo:String):void
        {
            executeServiceCall(gruposService.alumnosNoInscritos(busqueda, ciclo), alumnosNoInscritosResult, gruposFault);
        }

        private function alumnosNoInscritosResult(event:ResultEvent):void {
            if(event.result.hasOwnProperty('error')){
                Alert.show(event.result.error, "Error");
            }else{
                gruposModel.alumnosNoInscritosList = new ArrayCollection(event.result as Array);
            }
        }


	}
}