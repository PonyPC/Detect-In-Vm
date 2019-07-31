  procedure GetCPUID(var AAx, ABx, ACx, ADx: Cardinal);
  var
    vAx, vBx, vCx, vDx: Cardinal;
  begin
    vAx := AAx;
    vBx := ABx;
    vCx := ACx;
    vDx := ADx;
    asm
      push ebx 

      mov eax, vAx
      mov ebx, vBx
      mov ecx, vCx
      mov edx, vDx
      cpuid
      mov vAx, eax
      mov vBx, ebx
      mov vCx, ecx
      mov vDx, edx

      pop ebx
    end;

    AAx := vAx;
    ABx := vBx;
    ACx := vCx;
    ADx := vDx;
  end;
  function isVmTaskmgr: Boolean;
  var
    vAx, vBx, vCx, vDx: Cardinal;
  begin
    vAx := 1; //parse leaf 0x01
    GetCPUID(vAx, vBx, vCx, vDx);
    if vCx shr 31 = 1 then //determine hypervisor bits
    begin
      Result := True;
    end
    else
    begin
      Result := false;
    end;
  end;
