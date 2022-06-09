# .NEt Codes
## Convert Documents en Bytes a PDF

    var filePath = @$"{Raiz}\\{NombreDocumento}.pdf";   
    File.WriteAllBytes(filePath, DocumentoEnBytes);


## Imprimir archivo pdf Guardado en Ruta
File.Copy(@$"{path}", @$"{printPropName}");

## Validar User Session
private readonly string valDomain = @""
private readonly string valUserAdmin = @""
private readonly string valPassAdmin = @""
System.DirectoryServices --Last version
System.DirectoryServices.AccountManagement --Last version

 public async Task<bool> ValidateCredentials(string sUserName, string sPassword)
        {
            System.DirectoryServices.AccountManagement.PrincipalContext oPrincipalContext = GetPrincipalContext();
            return oPrincipalContext.ValidateCredentials(sUserName, sPassword);
        }

         public PrincipalContext GetPrincipalContext()
        {
            PrincipalContext oPContext = new PrincipalContext
               (ContextType.Domain, valDomain,
               valUserAdmin, sServicePavalPassAdminssword);
            return oPContext;
        }   

