<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js"></script>

<div id="commentViewDialog2" title="의견 교환창" class="basicTable" style="display: none;">
    <div>
<%--        <button type="button" id="commentViewDialog2Refresh" class="reset" title="Refresh"></button>--%>
        <ul id="commentListViewer2" class="commentWrap" style="height: 414px; margin-bottom:10px; overflow:auto;">

        </ul>
        <textarea id="commentContent2" name="commentContent" class="observerOffset" rows="4" placeholder="코멘트를 작성해 주시기 바랍니다." type="text" value="" >
        </textarea>
        <button id="commentWrite2" class="focusA" type="button" style="width:100%;">의견 등록</button>
    </div>
</div>
<script>
    $("#commentViewDialog2Refresh").click(()=> {
        commentViewDialog2.dialog("close");
        commentViewDialog2.dialog("open");
    });
    $("#commentWrite2").click(()=>{
        const commentContent = $("#commentContent2").val();
        const objectName = $("#commentListViewer2").attr("objectname");
        let commentData = {
            objectName: objectName,
            commentContent: commentContent
        };

        $.ajax({
            url: "/data/simulation-rest/commentRegisterConstructProcess",
            type: "POST",
            headers: {"X-Requested-With": "XMLHttpRequest"},
            data: commentData,
            // dataType: "json",
            success: function(commentList){
                console.log(commentList);
                commentViewFunc2(commentList);
                $("#commentContent2").val("");
            },
            error:function(request,status,error) {
                console.log("err=", request, status, error);
            }
        });
    });



</script>

<style>

    #commentListViewer2 .id {
        padding-right: 15px;
    }
    #commentViewDialog2 textarea{
        width: 100%;
        margin-bottom: 5px;
        resize: none;
    }
    #commentListViewer2 li {
        margin: 0px;
        cursor: default;
    }

    #commentListViewer2 .commentTime {
        font-size: 10px;
        margin-top: -2px;
        margin-bottom: 5px;
        margin-left: 5px;
    }

</style>