/**
 * Created by Carlos Zaragoza on 19/09/14.
 */
package us.educative.VO {
public class IngresosVO {
    public var m_control_inscripcion_id:int;
    public var m_alumno_id:int;
    public var m_producto_servicio_id:int;
    public var m_descuento:int;
    public var m_tipo_descuento:String;
    public var m_cantidad_descuento:Number;
    public var d_mes_pago:int;
    public var d_fecha_pago:String;
    public var d_fecha_registro:String;
    public var d_monto_de_pago:Number;
    public var d_recargo:int; //Tipo boolean entre 1 y 0
    public var d_tipo_recargo:String= "%"; //Este es interno, siembre va "%"
    public var d_cant_recargo:Number;
    public var d_referencia:String;
    public var d_cuenta_id:int;
    public var d_observaciones:String;
    public var m_usuario:int;
    public var d_metodo_pago:String; //Siempre puede ser T. tarjeta,
    public var por_pagar:Number;
	public var id_registro_pago:Number;

    /*
    * IN m_control_inscripcion_id INT,
     IN m_alumno_id INT,
     IN m_producto_servicio_id INT,
     IN m_descuento TINYINT(1),
     IN m_tipo_descuento VARCHAR(1) ,
     IN m_cantidad DECIMAL(10,0),
     IN d_mes VARCHAR(15),
     IN d_fecha_pago DATE,
     IN d_fecha_registro DATE,
     IN d_monto FLOAT,
     IN d_recargo TINYINT(1),
     IN d_tipo_recargo VARCHAR(1),
     IN d_cant_recargo FLOAT,
     IN d_referencia VARCHAR(150),
     IN d_cuenta_id INT,
     IN d_observaciones VARCHAR(250),
     IN m_usuario_id INT,
     IN d_metodo_pago varchar(1))
    * */
    public function IngresosVO() {
    }
}
}
