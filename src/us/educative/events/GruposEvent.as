package us.educative.events
{
    import flash.events.Event;

    import us.educative.VO.ControlInscripcionVO;

    public class GruposEvent extends Event
    {
        public static const GRUPOS_BUSCAR_PERIODOS:String = "gruposBuscarPeriodos";
        public static const GRUPOS_GET_ALL:String = "gruposGetAll";
        public static const GRUPOS_GUARDAR:String = "gruposGuardar";
        public static const GRUPOS_ACTUALIZAR:String = "gruposActualizar";
        public static const GRUPOS_LIMPIAR_FORMULARIO:String = "gruposLimpiarFormulario";
        public static const GRUPOS_LIMPIAR_FORMULARIO_AFTER_UPDATE:String = "gruposLimpiarFormularioAfterUpdate";
        public static const GRUPOS_BORRADOS:String = "gruposBorrados";
        public static const GRUPOS_BORRAR:String = "gruposBorrar";
        public static const GRUPOS_BUSCAR_LOS_NO_INSCRITOS:String = "gruposBuscarLosNoInscritos";
        public static const GRUPOS_BUSCAR_ALUMNO:String = "gruposBuscarAlumno"

        public var busqueda:String;
        public var controlInscripcion:ControlInscripcionVO;
        public var datagrid:Object;
        public var alumno:Object;
		public var plan:Object;
        public static const GRUPOS_INSCRIBIR_ALUMNO:String = "grposInscribirAlumno";
        public static const GRUPOS_REFRESCAR_INSCRITOS:String = "gruposRefrescarInscritos";
        public static const GRUPOS_LANZAR_BUSQUEDA_DESDE_VISTA:String = "gruposLanzarBusquedaDesdeVista";
        public static const GRUPOS_CARGAR_PLAN_DE_PAGOS:String =  "gruposCargarPlanDePagos";
        public static const GRUPOS_APLICA_PLAN_DE_PAGOS:String = "gruposAplicaPlanDePagos";
        public var ciclo:String;



        public function GruposEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
        {
            super(type, bubbles, cancelable);
        }


    }
}