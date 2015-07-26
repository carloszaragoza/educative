package us.educative.views.components
{
import flash.events.Event;
import flash.events.MouseEvent;

import mx.collections.IViewCursor;
import mx.controls.Alert;
import mx.events.CloseEvent;
import mx.managers.PopUpManager;
import mx.validators.Validator;

import spark.collections.Sort;
import spark.collections.SortField;
import spark.components.Group;
import spark.components.TitleWindow;

import us.educative.VO.ControlInscripcionVO;
import us.educative.events.AlumnoEvent;
import us.educative.events.EmpleadoEvent;
import us.educative.events.GruposEvent;
import us.educative.events.PadresEvent;
import us.educative.models.AlumnoModel;
import us.educative.models.CommonModel;
import us.educative.models.EmpleadoModel;
import us.educative.models.GruposModel;
import us.educative.models.NivelEducativoModel;
import us.educative.models.PeriodoModel;
import us.educative.views.body.CargaPlanDePagos;
import us.educative.views.body.UbicaFamiliar;

    public class GruposBase extends Group
    {
        [Inject]
        [Bindable] public var periodoModel:PeriodoModel;

        [Inject]
        [Bindable] public var empleadoModel:EmpleadoModel;

        [Inject]
        [Bindable] public var nivelEducativoModel:NivelEducativoModel;

        [Inject]
        [Bindable] public var gruposModel:GruposModel;

        [Inject]
        [Bindable] public var alumnosModel:AlumnoModel;

        [Inject]
        [Bindable] public var commonModel:CommonModel;

        private var view:Grupos = Grupos(this);
        [Bindable] public var isUpdated:Boolean = false;
        [Bindable] public var grupoSelected:Object;
        private var idControlInscripcion:int;
        public function GruposBase()
        {
            super();
        }

        public function agregarAlumnoClic(updated:Boolean):void
        {
			var errores:Array = Validator.validateAll([view.validaGrupo]);
			if(errores.length == 0 && view.cboPeriodo.selectedIndex != -1 && view.cboNivelEducativo.selectedIndex != -1 && view.cboProfesor.selectedIndex != -1)
			{
				var control:ControlInscripcionVO = new ControlInscripcionVO();
				control.periodo_id = view.cboPeriodo.selectedItem.id_periodo;
				control.nivel_educativo_id = view.cboNivelEducativo.selectedItem.id_nivel_educativo;
				control.grado = view.nsGrado.value.toString() ;
				control.grupo = view.txtGrupo.text;
				control.empleado_id = view.cboProfesor.selectedItem.id_empleado;
				
				if(updated)
				{
					control.id_control_inscripcion = idControlInscripcion;
					var eventActualizarGrupo:GruposEvent = new GruposEvent(GruposEvent.GRUPOS_ACTUALIZAR);
					eventActualizarGrupo.controlInscripcion = control;
					dispatchEvent(eventActualizarGrupo);
				}else{
					var eventGuardarGrupo:GruposEvent = new GruposEvent(GruposEvent.GRUPOS_GUARDAR);
					eventGuardarGrupo.controlInscripcion = control;
					dispatchEvent(eventGuardarGrupo);
				}
			} else
			{
				Alert.show("Selecciona todos los elementos para continuar");
			}
            
        }
        [EventHandler(event="GruposEvent.GRUPOS_BORRADOS")]
        public function busquedaPeriodoGrupo():void
        {
            var eventBuscarPeriodos:GruposEvent = new GruposEvent(GruposEvent.GRUPOS_BUSCAR_PERIODOS);
            var control:ControlInscripcionVO = new ControlInscripcionVO();
            control.periodo_id = view.cboPeriodoBusqueda.selectedItem.id_periodo;

            eventBuscarPeriodos.controlInscripcion = control;

            dispatchEvent(eventBuscarPeriodos);
        }

        [EventHandler(event="GruposEvent.GRUPOS_LIMPIAR_FORMULARIO")]
        public function clearControls():void
        {
            view.cboPeriodo.selectedIndex = 0;
            view.cboNivelEducativo.selectedItem = 0;
            view.nsGrado.value = 1;
            view.txtGrupo.text = "";
            view.cboProfesor.selectedItem = -1;




        }

        [EventHandler(event="GruposEvent.GRUPOS_LIMPIAR_FORMULARIO_AFTER_UPDATE")]
        public function clearControlsAfterUpdate():void
        {
            clearControls();
            idControlInscripcion = 0;
            isUpdated = false;

        }
        private var cursorPeriodo:IViewCursor;
        private var cursorNivelEducativo:IViewCursor;
        private var cursorProfesor:IViewCursor;
        public function modificarAlumno(data:Object):void
        {
            doSort('id_periodo',periodoModel.periodoList);
            cursorPeriodo = periodoModel.periodoList.createCursor();
            var found:Boolean = cursorPeriodo.findAny(data);
            if (found)
            {
                view.cboPeriodo.selectedItem = cursorPeriodo.current;
            }

            doSort('id_nivel_educativo', nivelEducativoModel.nivelEducativoList);
            cursorNivelEducativo = nivelEducativoModel.nivelEducativoList.createCursor();
            var foundEducativo:Boolean = cursorNivelEducativo.findAny(data);
            if(foundEducativo)
            {
                view.cboNivelEducativo.selectedItem = cursorNivelEducativo.current;
            }

            doSort('id_empleado', empleadoModel.profesorList);
            cursorProfesor = empleadoModel.profesorList.createCursor();
            var foundProfesor:Boolean = cursorProfesor.findAny(data);
            if (foundProfesor)
            {
                view.cboProfesor.selectedItem = cursorProfesor.current;
            }
            view.nsGrado.value = data.grado;
            view.txtGrupo.text = data.grupo;
            idControlInscripcion = data.id_control_inscripcion;

            isUpdated = true;



            view.viewStackContenido.selectedIndex = 0;


        }

        private function doSort(campo:String, arreglo:*):void{
            var sf:SortField = new SortField(campo);
            var s:Sort = new Sort();
            s.fields = [sf];
            arreglo.sort = s;
            arreglo.refresh();
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
                var eventBorrar:GruposEvent = new GruposEvent(GruposEvent.GRUPOS_BORRAR);
                eventBorrar.datagrid = objeto;
                dispatchEvent(eventBorrar);
            }
        }

        public function refreshProfesores():void
        {

            dispatchEvent(new EmpleadoEvent(EmpleadoEvent.EMPLEADO_GET_PROFESORES));
        }

        public function seleccionarGrupo(event:Event, data:*):void
        {
            grupoSelected = data;
            view.viewStackContenido.selectedIndex = 2;
            refreshInscritos();

        }
		
        [EventHandler(event="GruposEvent.GRUPOS_BUSCAR_ALUMNO")]
        public function buscarAlumno():void
        {
            var eventBuscarAlumnos:GruposEvent = new GruposEvent(GruposEvent.GRUPOS_BUSCAR_LOS_NO_INSCRITOS);
            eventBuscarAlumnos.busqueda = view.txtBusqueda.text;
            eventBuscarAlumnos.ciclo = grupoSelected.periodo;
            dispatchEvent(eventBuscarAlumnos);
        }
        public function inscripcionAlumno(event:MouseEvent):void {
            var eventInscrpcion:GruposEvent = new GruposEvent(GruposEvent.GRUPOS_INSCRIBIR_ALUMNO);
            eventInscrpcion.alumno = event.currentTarget.selectedItem;
            eventInscrpcion.alumno.id_control_inscripcion = grupoSelected.id_control_inscripcion;
            eventInscrpcion.alumno.id_usuario = commonModel.id_usuario;
            dispatchEvent(eventInscrpcion);
			//lanzar popup para 
        }
        [EventHandler(event="GruposEvent.GRUPOS_LANZAR_BUSQUEDA_DESDE_VISTA")]
        public function refreshInscritos():void
        {
            var eventRefrescarInscritos:GruposEvent = new GruposEvent(GruposEvent.GRUPOS_REFRESCAR_INSCRITOS);
            var control:ControlInscripcionVO = new ControlInscripcionVO();
            control.id_control_inscripcion = grupoSelected.id_control_inscripcion;
            eventRefrescarInscritos.controlInscripcion = control;
            dispatchEvent(eventRefrescarInscritos);
        }

        public function habilidaInscripcion(event:MouseEvent):void
        {
            trace(event.currentTarget.selectedIndex);
            if(event.currentTarget.selectedIndex == 2)
            {
                if(!grupoSelected){
                    view.tabbarGrupos.selectedIndex = 1;
                }
            }
        }
		
		

    }
}