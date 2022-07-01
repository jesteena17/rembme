<cfscript>
               op = {result="myresult", datasource="GetmyticketDSN", fetchclientinfo="yes"};
               qr = QueryExecute("select * from tbl_movies order by movieid", [] ,op);
               
               function mq(any Obj){
                              WriteDump(Obj);
               }
             //  WriteOutput("QueryEach: ");
             //  QueryEach(qr, mq);
               res=QueryExecute("SELECT * FROM tbl_movies",[],{datasource="GetmyticketDSN"});
      
       res.each(function(count){
             ml=#count.mvname#;
         //    WriteOutput(ml&"<br>");
       });
   
     filteredQuery=QueryFilter(res,function(obj){
       return obj.movieid>=7
    })
    // writeOutput("The filtered query is:")
    // writeDump(filteredQuery);


         
               function filterQuery(any Obj){
                              return (Obj.mvname == "oruthee" ? true : false);
               }
 //WriteDump(QueryFilter(res, filterQuery));

  myGet=QueryGetRow(res,2);
  // WriteDump(myGet);

                
    status=QueryKeyExists(res,"MVNAME");
    //    if (status=="YES"){
    //          writeOutput("Matching column exists: "& status);
    //    }
    //    else{
    //          writeOutput("Matching column exists: "& status);
    //    }


         qmap=QueryMap(res,function(obj){
        if (obj.movieid>8){
            obj.mvname="Hello " & obj.mvname
            return obj
        }
        else{
            obj.mvname="Hi " & obj.mvname
            return obj
        }
    })
    // writeOutput("The new query is:")
    // writeDump(qmap);

res=QueryExecute("SELECT * FROM tbl_payment",[],{datasource="GetmyticketDSN"});
     tot=QueryReduce(res,function(sum,obj){
        sum=sum+obj.amount
        return sum
    },0)
   // writeOutput("The sum of all amount is: " & tot);

//writeDump(listRemoveDuplicates("one,two,three,four,five,one,five,three"));
writedump(listContains("jes,teena,baby,jesty,jinu", "jes"));
</cfscript>