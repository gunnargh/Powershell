#Always run as administrator!!!
			     $getDLL = Get-ChildItem ".\FOLDER" | where{ $_.Extension -like "*.dll" }
                             $getDLL += Get-ChildItem ".\ANOTHERFOLDER" | where{ $_.Extension -like "*.dll" }
                             [Reflection.Assembly]::LoadWithPartialName("System.EnterpriseServices")
                             [System.EnterpriseServices.Internal.Publish]$publish = new-object System.EnterpriseServices.Internal.Publish
                            
                             foreach ($dll in $getDLL)
                             {
                                                          $publish.GacInstall($dll.FullName)
                             }