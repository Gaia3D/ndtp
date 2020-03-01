<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js"></script>

<div id="commentRegisterDialog" title="의견 등록" class="basicTable" style="display: none;">
    <div>
        <div style="height: 90%;">
                <ul class="analysisGroup">
                    <li>
                        <label for="commentTitle">제목</label>
                        <input id="commentTitle" name="commentTitle" class="observerOffset" placeholder="제목 입력" type="text" value="" >
                    </li>
                    <li>
                        <label for="commentContent">내용</label>
                        <textarea id="commentContent" name="commentContent" class="observerOffset" rows="13" placeholder="코멘트를 작성해 주시기 바랍니다." type="text" value="" >
                        </textarea>
                    </li>

                </ul>
        </div>
        <button id="commentSave" class="focusA" type="button" style="width:100%;">저장</button>
    </div>
</div>
<script>
    $("#commentSave").click(()=> {
        debugger;
        const permSeq = buildAcceptPermSeq;
        const commentTitle = $("#commentTitle").val();
        const commentContent = $("#commentContent").val();
        let commentData = {
            permSeq: permSeq,
            commentTitle: commentTitle,
            commentContent: commentContent
        };
        debugger;
        $.ajax({
            url: "/data/simulation-rest/commentRegister",
            type: "POST",
            headers: {"X-Requested-With": "XMLHttpRequest"},
            data: commentData,
            // dataType: "json",
            success: function(commentList){
                commentViewFunc(commentList);

                $("#commentRegisterDialog").dialog("close");
            },
            error:function(request,status,error) {
                console.log("err=", request, status, error);
            }
        });
    })


</script>

<style>
    #commentRegisterDialog label {
        width: 80px;
    }
    #commentRegisterDialog input, textarea{
        width: 70%;
    }

</style>