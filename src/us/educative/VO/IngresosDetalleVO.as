/**
 * Created by Carlos Zaragoza on 19/09/14.
 */
package us.educative.VO {
public class IngresosDetalleVO {

    public var registro_pago_id;
    public var numero_pago;
    public var mes:String;
    public var fecha_pago:String;
    public var fecha_registro:String;
    public var monto:Number;
    public var recargo:int; //booelan
    public var tipo_recargo:String;
    public var cantidad_recargo:Number;
    public var referencia:String;
    public var cuenta_id:int;
    public var observaciones:String;
    public var usuario_id:int;
    public function IngresosDetalleVO() {
    }
}
}
