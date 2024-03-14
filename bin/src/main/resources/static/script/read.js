// 페이지가 로드되면 댓글을 불러옵니다.
$(document).ready(function() {
    loadComments();
});


// 댓글을 불러오는 함수
function loadComments(callback) {
	var pno = $("#pno").val();

	$.ajax({
		type: "GET",
		url: "/comments/" + pno,
		success: function(data) {
			$("#commentsContent").val('');  // 입력란을 비웁니다.

			// 기존에 페이지에 있던 댓글들에 대한 HTML을 제거합니다.
			$(".comment-list").empty();
			// 각 댓글에 대해 HTML을 생성하고 추가합니다.
			data.forEach(function(comment) {


				// 서버에서 반환된 날짜/시간 문자열을 Date 객체로 변환합니다.
				var commentDate = new Date(comment.commentsCreatedate);

				// Date 객체를 원하는 형식의 문자열로 변환합니다.
				var formattedDate = commentDate.getFullYear() + '-'
					+ (commentDate.getMonth() + 1).toString().padStart(2, '0') + '-'
					+ commentDate.getDate().toString().padStart(2, '0') + ' '
					+ commentDate.getHours().toString().padStart(2, '0') + ':'
					+ commentDate.getMinutes().toString().padStart(2, '0') + ':'
					+ commentDate.getSeconds().toString().padStart(2, '0');

				var commentHtml = '<div class="comment-item">'
					+ '<div class="comment-header">'
					+ '<div class="comment-box">' + comment.nickname + '</div>'  // 닉네임
					+ '<div class="comment-info">' + formattedDate + '</div>'  // 포맷된 댓글 작성일
					+ '<div class="comment-actions">'
					+ '<button class="top-comment" onclick="showReplyForm(this)">답글</button>'
					+ '</div>'
					+ '</div>'
					+ '<p>' + comment.commentsContent + '</p>'  // 댓글 내용
					+ '<div id="myBox"></div>'
					+ '</div>';

				$(".comment-list").append(commentHtml);
			});
			
			console.log("댓글 목록 불러오기 성공!");  // 로그 출력
			       // 모든 댓글이 DOM에 추가된 후에 콜백 함수를 실행합니다.
            if (typeof callback === 'function') {
                callback();
            }
		},
		error: function(jqXHR, textStatus, errorThrown) {
			// 오류 처리 코드를 여기에 작성합니다.
		}
	});
}

// 댓글 작성 함수
function createComment(e) {
    e.preventDefault();
    console.log("createComment 함수 호출!");  // 함수 호출 로그 출력
    var pno = $("#pno").val();
    console.log("pno: ", pno);  // 'pno' 값 로그 출력

    var comment = {
        pno: pno,
        commentsContent: $("#commentsContent").val(),
        // 필요한 다른 필드를 여기에 추가하세요.
    };

 $.ajax({
        type: "POST",
        url: "/comments",
        data: JSON.stringify(comment),
        contentType: "application/json",
        success: function(data) {
            loadComments(function() {
                // 새로 작성한 댓글을 선택합니다.
                var $newComment = $(".comment-list .comment-item:last");
                 console.log("새 댓글: ", $newComment);  // 로그 출력
                // 새로 작성한 댓글이 천천히 반짝이도록 합니다.
                $newComment.css("background-color", "rgba(255, 255, 192, 1)");
                $newComment.animate({
                    opacity: 0.5
                }, 4000, function() {
                    // 애니메이션이 끝나면 원래의 배경색으로 돌아갑니다.
                    $newComment.css("background-color", "");
                    $newComment.css("opacity", "");
                });
            });
        },
        error: function(jqXHR, textStatus, errorThrown) {
            // 오류 처리 코드를 여기에 작성합니다.
        }
    });
}
	



//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ

// 'Enter' 키 이벤트에 댓글 작성 함수 바인딩
$(document).on("keypress", "#commentsContent", function(e) {
	if (e.which == 13) {
		e.preventDefault();
		createComment(e);
	}
});
// 작성 버튼 눌렀을때
$(document).on("click", "#submitComment", function(e) {
	e.preventDefault();
	console.log("작성 버튼 클릭!");  // 로그 출력
	createComment(e);
});




//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ


// 답글 버튼 클릭 이벤트 핸들러
function showReplyForm(button) {
	var myBox = document.getElementById('myBox');
	var replyForm = myBox.querySelector('.reply-form');

	if (button.getAttribute('data-active') === 'true') {
		// 이미 답글 폼이 열려 있으면, 답글 폼을 닫고 버튼의 상태를 '닫힘'으로 변경
		if (replyForm) {
			myBox.removeChild(replyForm);
		}
		button.setAttribute('data-active', 'false');
	} else {
		// 답글 폼이 닫혀 있으면, 답글 폼을 열고 버튼의 상태를 '열림'으로 변경
		if (!replyForm) {
			replyForm = document.createElement('form');
			replyForm.innerHTML = `
        <div class="reply-form__container">
          <div class="reply-form__user-info">
            <span class="reply-form-title">답글 작성</span>
            <input class="reply-form-user-input" type="text" disabled="disabled" value="이리이리이리">
          </div>
          <div class="reply-form-textarea-wrapper">
            <textarea class="reply-form-textarea" id="comment" name="comment" rows="4"></textarea>
            <div class="form-footer">
              <button type="submit">작성</button>
            </div>
          </div>
        </div>
      `;
			replyForm.classList.add('reply-form');
		}
		myBox.appendChild(replyForm);
		button.setAttribute('data-active', 'true');
	}
}
