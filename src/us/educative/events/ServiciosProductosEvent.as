/**
 * Created by carlos on 8/11/14.
 */
package us.educative.events {
import flash.events.Event;

import us.educative.VO.ServiciosProductosVO;

public class ServiciosProductosEvent extends Event
{
    public static const SERVICIOS_PRODUCTOS_ACTUALIZAR:String = "serviciosProductosActualizar";
    public static const SERVICIOS_PRODUCTOS_GUARDAR:String = "serviciosProductosGuardar";
    public static const SERVICIOS_PRODUCTOS_BORRAR:String = "serviciosProductosBorrar";
    public static const SERVICIOS_PRODUCTOS_GET_ALL:String = "serviciosProductosGetAll";
    public static const SERVICIOS_PRODUCTOS_GET_BY_FILTER:String = "serviciosProductosGetByFilter";
	public static const SERVICIOS_PRODUCTOS_LIMPIA_FORMULARIO_UPDATE:String = "serviciosProductosLimpiaFormularioUpdate";
	public static const SERVICIOS_PRODUCTOS_LIMPIA_FORMULARIO:String = "serviciosProductosLimpiaFormulario";

    public var serviciosProductos:ServiciosProductosVO;
    public var busqueda:String;
    public var busquedObjeto:Object;
	public var datagrid:Object;

    public function ServiciosProductosEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
    {
        super(type, bubbles, cancelable);
    }
}
}
