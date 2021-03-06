xquery version "1.0-ml";
(:~
 : Base Edit Template used for rendering output
~:)
declare default element namespace "http://www.w3.org/1999/xhtml";
declare namespace domain = "http://www.xquerrail-framework.com/domain";

import module namespace form = "http://www.xquerrail-framework.com/formbuilder" at "/_framework/helpers/formbuilder.xqy";
import module namespace response = "http://www.xquerrail-framework.com/response" at "/_framework/response.xqy";

declare option xdmp:output "indent-untyped=yes";
declare variable $response as map:map external;

let $init := response:initialize($response)
let $domain-model := response:model()

let $labels := 
    if(response:body()/*:uuid) then      
        ("Update","Save")
    else 
        ("New", "Create") 
return
    <div>
         <div class="content-box">
            <form id="form_{response:controller()}" name="form_{response:controller()}" method="post"
                  action="/{response:controller()}/post.json"
                  onsubmit="return validateSave('form_{response:controller()}','{response:controller()}_table');">        
                 <?template name="fields"?> 
              <ul>
                 <li class="buttons">
                 <a class="ui-state-default ui-corner-all ui-button" href="#"
                    onclick="return validateSave('form_{response:controller()}','{response:controller()}_table');">{$labels[2]}
                 </a>
                 {     
                      (: If there is a UUID this will be an update form :)
                      (: allow the user to remove the item from the DB :)
                      if(response:body()/*:uuid) then      
                      <a href="/{response:controller()}/remove.html?uuid={response:body()/*:uuid}" class="ui-state-default ui-corner-all ui-button"
                                 onclick="return validateDelete(this,'{response:controller()}_table');">
                       Remove</a>
                      else ()
                 }  
                </li>
             </ul>
            </form>
         </div> <!-- end content-box -->
     </div>