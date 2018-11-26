program XNAT_Internet;

{$APPTYPE CONSOLE}

{$R *.res}

{
  XNAT�Ĺ��������������ڹ���Э��ӿ�
  XNAT��MobileServer�ǹ������ֻ�����IOT�豸�ķ�����ģ��
  �ڹ���Э��ӿ��У�XNATʹ����P2PVM��������ʾ��������ֻ���������������ӵķ���

  XNAT��������������������4000
}

uses
  SysUtils,
  CoreClasses,
  PascalStrings,
  UnicodeMixedLib,
  CommunicationFramework,
  xNATService,
  DoStatusIO;

var
  XServ: TXNATService;

begin
  try
    XServ := TXNATService.Create;
    {
      ��͸Э��ѹ��ѡ��
      ����ʹ�ó���:
      ��������������Ѿ�ѹ����������ʹ��https���෽ʽ���ܹ���ѹ������Ч������ѹ�������ݸ���
      ���ʱ������Э�飬����ftp,����s��http,tennet��ѹ�����ؿ��Դ򿪣�����С������

      �����Ż�˼·��ZLib��ѹ���㷨������ѹ��������ѹ�ǳ��죬�÷�������������ʱ����ѹ�����ÿͻ��˷�������ȫ��ѹ��
      ��TXServiceListenʵ���е��� SendTunnel.CompleteBufferCompressed:=False;
      ��TXClientMappingʵ���е��� SendTunnel.CompleteBufferCompressed:=True;
      ��TXNAT_MappingOnVirutalServerʵ���е��� SendTunnel.CompleteBufferCompressed:=True;
    }
    XServ.ProtocolCompressed := True;

    XServ.TunnelListenAddr := '0.0.0.0'; // ��������������ͨѶ������Э�������󶨵�ַΪ����������ipv4�������ipv6��д'::'
    XServ.TunnelListenPort := '7890';    // ��������������ͨѶ������Э��˿�
    XServ.AuthToken := '123456';         // ��������������ͨѶ������Э����֤�ַ���(�ñ�ʶ��ʹ���˿���������ģ�ͣ���ؼ����������о�����)

    {
      ��������
    }
    XServ.AddMapping('0.0.0.0', '18888', 'my18888'); // �ڷ���������Ҫӳ��Ķ˿�8000���󶨵�ַΪ����������ipv4

    XServ.OpenTunnel;

    while True do
      begin
        XServ.Progress;
        try
            CoreClasses.CheckThreadSynchronize(1);
        except
        end;
      end;

  except
    on E: Exception do
        Writeln(E.ClassName, ': ', E.Message);
  end;

end.