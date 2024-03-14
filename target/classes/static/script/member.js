// 페이지 로딩이 완료되면 아이디 중복 검사와 회원가입 폼 설정을 수행
document.addEventListener('DOMContentLoaded', function() {
	setupIdCheck();
	setupPasswordCheck(); // 이 줄을 추가
	setupFormSubmit();
});

//----------------아이디 중복확인-------------------------------

// 아이디 중복 검사 결과를 저장하는 변수
var isIdAvailable = false;

// 서버에 memberId를 전송하여 아이디 중복 검사를 수행하는 함수
function checkId(memberId) {
	$.ajax({
		url: '/check-id', // 요청을 보낼 URL
		type: 'GET', // HTTP 메서드
		data: { memberId: memberId }, // 서버에 전송할 데이터
		success: function() { // 요청이 성공한 경우 실행할 함수
			updateMsg('사용 가능한 아이디입니다.', 'green', 'memberId-msg'); // 수정된 부분
			isIdAvailable = true; // 아이디 사용 가능
			checkSubmitAvailability();
		},
		error: function(jqXHR) { // 요청이 실패한 경우 실행할 함수
			var msg = jqXHR.status === 409 ? '이미 사용 중인 아이디입니다.' : '아이디 검사 중 에러가 발생했습니다.';
			updateMsg(msg, 'red', 'memberId-msg'); // 수정된 부분
			isIdAvailable = false; // 아이디 사용 불가능
			checkSubmitAvailability();
		}
	});
}


// 화면에 메시지를 표시하는 함수
function updateMsg(msg, color, elementId) {
	var msgElement = document.getElementById(elementId); // 메시지를 표시할 HTML 요소 선택
	msgElement.innerText = msg; // 메시지 내용 설정
	msgElement.style.color = color; // 메시지 색상 설정
}




// 아이디 입력 필드에 이벤트 리스너를 추가하는 함수
function setupIdCheck() {
	var memberIdField = document.querySelector('#memberId'); // 아이디 입력 필드 선택
	if (memberIdField) {
		memberIdField.addEventListener('input', function() { // 입력 이벤트 리스너 추가
			var memberId = memberIdField.value; // 현재 입력된 아이디 가져오기
			var validationResult = fn_validateId(memberId); // 아이디 유효성 검사

			if (validationResult) { // 유효성 검사 결과가 있으면 (즉, 에러 메시지가 있으면)
				updateMsg(validationResult, 'red', 'memberId-msg');
			} else if (memberId) { // 아이디가 입력되어 있으면
				checkId(memberId);
			} else { // 아이디가 입력되어 있지 않으면
				updateMsg('', 'black', 'memberId-msg');
			}
		});
	}
}


// 아이디의 유효성을 검사하는 함수
function fn_validateId(id) {
	var spe = id.search(/[`~!@#$%^&*|\\'";:/?]/gi); // 특수문자가 있는지 검사
	var korean = id.search(/[가-힣ㄱ-ㅎㅏ-ㅣ]/g); // 한글이 있는지 검사

	if (!id.trim()) return ''; // 아이디가 공백인 경우 빈 문자열 반환
	if (id.length < 6 || id.length > 20) return '아이디의 길이는 6~20자 사이여야 합니다.'; // 길이 검사
	if (id.search(/\s/) != -1) return '아이디는 공백없이 입력해주세요.'; // 공백이 있는지 검사
	if (spe != -1 || korean != -1) return '아이디는 영문,숫자만 입력해주세요.'; // 특수문자 또는 한글이 있는지 검사
	return ''; // 유효성 검사를 통과하면 빈 문자열 반환
}




//-------------------------------------------------




// 비밀번호의 유효성을 검사하는 함수
function fn_validatePassword(password) {
	var regex = /^(?=.*[a-z])(?=.*\d)(?=.*[^\da-zA-Z]).{8,20}$/;
	if (!password.match(regex)) {
		return '비밀번호는 8~20자 사이이며, 숫자, 소문자, 특수 문자를 각각 최소 하나 이상 포함해야 합니다.';
	}
	return '';
}

function setupPasswordCheck() {
	var passwordField = document.querySelector('#password');
	var passwordConfirmField = document.querySelector('#password_confirm');

	if (passwordField && passwordConfirmField) {
		passwordField.addEventListener('input', function() {
			var password = passwordField.value;
			var validationResult = fn_validatePassword(password);

			if (validationResult) {
				updateMsg(validationResult, 'red', 'password-msg');
			} else {
				if (password === '') {
					updateMsg('비밀번호를 입력해 주세요.', 'red', 'password-msg'); // 추가된 부분
				} else {
					updateMsg('사용 가능한 비밀번호입니다.', 'green', 'password-msg');
				}
			}

			if (password !== passwordConfirmField.value) {
				updateMsg('비밀번호가 일치하지 않습니다.', 'red', 'password_check-msg');
			} else {
				if (passwordConfirmField.value === '') {
					updateMsg('비밀번호를 입력해 주세요.', 'red', 'password_check-msg'); // 추가된 부분
				} else {
					updateMsg('비밀번호가 일치합니다.', 'green', 'password_check-msg');
				}
			}
		});

		passwordConfirmField.addEventListener('input', function() {
			if (passwordField.value !== passwordConfirmField.value) {
				updateMsg('비밀번호가 일치하지 않습니다.', 'red', 'password_check-msg');
			} else {
				if (passwordConfirmField.value === '') {
					updateMsg('비밀번호를 입력해 주세요.', 'red', 'password_check-msg'); // 추가된 부분
				} else {
					updateMsg('비밀번호가 일치합니다.', 'green', 'password_check-msg');
				}
			}
		});
	}
}





//-----------------회원가입 폼-------------------------------

function setupFormSubmit() {
	var form = document.querySelector('form');

	if (form) {
		form.addEventListener('submit', function(e) {
			var memberIdField = document.querySelector('#memberId');
			var passwordField = document.querySelector('#password');
			var passwordConfirmField = document.querySelector('#password_confirm');
			var emailField = document.querySelector('#email');
			var nameField = document.querySelector('#name');
			var nicknameField = document.querySelector('#nickname');
			var birthdayField = document.querySelector('#birthday');

			if (memberIdField) {
				if (memberIdField.value === '') {
					updateMsg('아이디를 입력해주세요.', 'red', 'memberId-msg');
					e.preventDefault();
				} else {
					updateMsg('', '', 'memberId-msg'); // 입력이 완료되면 메시지를 지움
				}
			}

			if (passwordField) {
				if (passwordField.value === '') {
					updateMsg('비밀번호를 입력해주세요.', 'red', 'password-msg');
					e.preventDefault();
				} else {
					updateMsg('', '', 'password-msg'); // 입력이 완료되면 메시지를 지움
				}
			}

			if (emailField) {
				if (emailField.value === '') {
					updateMsg('이메일을 입력해주세요.', 'red', 'email-msg');
					e.preventDefault();
				} else {
					updateMsg('', '', 'email-msg'); // 입력이 완료되면 메시지를 지움
				}
			}

			if (nameField) {
				if (nameField.value === '') {
					updateMsg('이름을 입력해주세요.', 'red', 'name-msg');
					e.preventDefault();
				} else {
					updateMsg('', '', 'name-msg'); // 입력이 완료되면 메시지를 지움
				}
			}

			if (nicknameField) {
				if (nicknameField.value === '') {
					updateMsg('닉네임을 입력해주세요.', 'red', 'nickname-msg');
					e.preventDefault();
				} else {
					updateMsg('', '', 'nickname-msg'); // 입력이 완료되면 메시지를 지움
				}
			}

			if (birthdayField) {
				if (birthdayField.value === '') {
					updateMsg('생년월일을 입력해주세요.', 'red', 'birthday-msg');
					e.preventDefault();
				} else {
					updateMsg('', '', 'birthday-msg'); // 입력이 완료되면 메시지를 지움
				}
			}

			if (passwordConfirmField) {
				if (passwordConfirmField.value === '') {
					updateMsg('비밀번호 확인란을 입력해주세요.', 'red', 'password_check-msg');
					e.preventDefault();
				} else {
					updateMsg('', '', 'password_check-msg'); // 입력이 완료되면 메시지를 지움
				}
			}



		});
	}
}





// 회원가입 제출 버튼의 활성화/비활성화를 결정하는 함수
function checkSubmitAvailability() {
	var submitButton = document.querySelector('form button[type="submit"]');
	if (submitButton) {
		submitButton.disabled = !isIdAvailable;
	}
}





//-------------------------------------------------
