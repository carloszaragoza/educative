package us.educative.services
{
	import mx.rpc.remoting.RemoteObject;
	public class HowardRemoteServices extends RemoteObject
	{
		public function HowardRemoteServices(destination:String = "", url:String = "http://10.10.10.:8080/nok/messagebroker/amf")
		{
			super(destination);
			this.endpoint = url;
		}
	}
}