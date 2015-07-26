/**
 * Created by carlos on 8/3/14.
 */
package us.educative.VO {
[Bindable]
public class ControlInscripcionVO {
    public var id_control_inscripcion:int;
    public var periodo_id:int;
    public var nivel_educativo_id:int;
    public var grado:String;
    public var grupo:String;
    public var empleado_id:int;
    public function ControlInscripcionVO() {
        this.id_control_inscripcion = 0;
        this.periodo_id = 0;
        this.nivel_educativo_id = 0;
        this.grado = "";
        this.grupo = "";
        this.empleado_id = 0;

    }
}
}
