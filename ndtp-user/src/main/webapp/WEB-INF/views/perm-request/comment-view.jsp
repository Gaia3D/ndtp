<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js"></script>

<div id="commentViewDialog" title="의견 교환창" class="basicTable" style="display: none;">
    <div>
<%--        <button type="button" id="commentViewDialogRefresh" class="reset" title="Refresh"></button>--%>
        <ul id="commentListViewer" class="commentWrap" style="height: 414px; margin-bottom:10px; overflow:auto;">

        </ul>
        <textarea id="commentContent" name="commentContent" class="observerOffset" rows="4" placeholder="코멘트를 작성해 주시기 바랍니다." type="text" value="" >
        </textarea>
        <button id="commentWrite" class="focusA" type="button" style="width:100%;">의견 등록</button>
    </div>
</div>
<script>
    $("#commentViewDialogRefresh").click(()=> {
        commentViewDialog.dialog("close");
        commentViewDialog.dialog("open");
    });
    $("#commentWrite").click(()=>{
        // commentRegisterDialog.dialog("open");
        const commentContent = $("#commentContent").val();
        let commentData = {
            commentContent: commentContent
        };
        $.ajax({
            url: "/data/simulation-rest/commentRegister",
            type: "POST",
            headers: {"X-Requested-With": "XMLHttpRequest"},
            data: commentData,
            // dataType: "json",
            success: function(commentList){
                console.log(commentList);
                commentViewFunc(commentList);
                $("#commentContent").val("");
            },
            error:function(request,status,error) {
                console.log("err=", request, status, error);
            }
        });
    });



</script>

<style>

    #commentListViewer .id {
        padding-right: 15px;
    }
    #commentViewDialog textarea{
        width: 100%;
        margin-bottom: 5px;
        resize: none;
    }
    #commentListViewer li {
        margin: 0px;
        cursor: default;
    }

    #commentListViewer .commentTime {
        font-size: 10px;
        margin-top: -2px;
        margin-bottom: 5px;
        margin-left: 5px;
    }

</style>