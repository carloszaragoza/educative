package us.educative.services
{
import mx.rpc.AsyncToken;
import mx.rpc.remoting.RemoteObject;

import us.educative.VO.ControlInscripcionVO;
import us.educative.config.EducativeConstants;

public class GruposService
{
    private var controlInscripcionRemoteObject:RemoteObject = new RemoteObject(EducativeConstants.SERVICE_CONTROL_INSCRIPCION);

    public function GruposService()
    {
        controlInscripcionRemoteObject.endpoint = EducativeConstants.SERVICE_END_POINT;
        controlInscripcionRemoteObject.source = EducativeConstants.SERVICE_CONTROL_INSCRIPCION;
    }

    public function getAll():AsyncToken
    {
        return controlInscripcionRemoteObject.getAll();
    }

    public function getGruposByPeriodosGrupos(control:ControlInscripcionVO):AsyncToken
    {
        return controlInscripcionRemoteObject.getGruposByPeriodosGrupos(control.periodo_id);
    }

    public function saveGrupo(control:ControlInscripcionVO):AsyncToken
    {
        return controlInscripcionRemoteObject.save(control.periodo_id, control.nivel_educativo_id, control.grado, control.grupo, control.empleado_id);
    }

    public function actualizar(control:ControlInscripcionVO):AsyncToken {
        return controlInscripcionRemoteObject.update(control.periodo_id, control.nivel_educativo_id, control.grado, control.grupo, control.empleado_id, control.id_control_inscripcion);
    }

    public function borrar(control:Object):AsyncToken {
        return controlInscripcionRemoteObject.deleteRecord(control.id_control_inscripcion);
    }

    public function inscribirAlumno(alumno:Object):AsyncToken {
        return controlInscripcionRemoteObject.inscribirAlumno(alumno.id_alumno, alumno.id_control_inscripcion, alumno.id_usuario);
    }

    public function refrescarGrupos(control:ControlInscripcionVO):AsyncToken {
        return controlInscripcionRemoteObject.refrescarGrupos(control.id_control_inscripcion);
    }

    public function alumnosNoInscritos(busqueda:String, ciclo:String):AsyncToken {
        return controlInscripcionRemoteObject.alumnosNoInscritos(busqueda, ciclo);
    }
}
}