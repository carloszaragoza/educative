/**
 * Created by carlos on 8/13/14.
 */
package us.educative.events {
import flash.events.Event;

import us.educative.VO.IngresosVO;

public class IngresosEvent extends Event {

    public static const INGRESOS_GET_ALL_GRUPOS:String = "ingresosGetAllGrupos";
	public static const INGRESOS_GET_ALL_ALUMNOS:String = "ingresosGetAllAlumnos";
	public static const INGRESOS_GET_ALL_CONCEPTOS:String = "ingresosGetAllConceptos";
	public static const INGRESOS_PAGO_ALUMNO:String = "ingresosPagoAlumno";
	public static const INGRESOS_TODOS_LOS_PAGOS_DEL_ALUMNO:String = "ingresosTodosLosPagosDelAlumno";
	public static const INGRESOS_BUSQUEDA_PAGOS:String = "ingresosBusquedaPagos";
	public static const INGRESOS_TRAE_TODOS_LOS_ALUMNOS:String = "ingresosTraeTodosLosAlumnos";
    
	
	public var id_nivel_educativo:int;
	public var pago:IngresosVO;
	public var busqueda:Object;
	public var alumno:Object;
	public static const INGRESOS_DETALLE_PAGO:String = "ingresosDetallePago";
	public var objeto:Object;
	public static const INGRESOS_BORRAR_PAGO:String = "ingresosBorrarPago";
	public static const INGRESOS_QUITAR_REGISTRO_GRID_BORRADO:String = "ingresosQuitarRegistroGridBorrado";
	
	
    public function IngresosEvent(type:String, bubbles:Boolean = true, cancelable:Boolean = false) {
        super(type, bubbles, cancelable);
    }
}
}
