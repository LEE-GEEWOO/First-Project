// 아이디 유효성 검사
function checkId(input) {
    const id = input.value;
    const idError = document.getElementById('id-error');
    if (id === "") {
        idError.textContent = "아이디를 입력하세요";
        return;
    }

    // 중복 검사 (가상 AJAX 호출 예제)
    fetch(`/9999/checkId.do?id=${encodeURIComponent(id)}`)
        .then(response => response.json())
        .then(data => {
            if (data.exists) {
                idError.textContent = "중복된 아이디가 있습니다";
                input.setCustomValidity("중복된 아이디가 있습니다");
            } else {
                idError.textContent = "";
                input.setCustomValidity("");
            }
        });
}
//

// 비밀번호 유효성 검사
function checkPwd(input) {
    const pwd = input.value;
    const pwdError = document.getElementById('pwd-error');
    if (pwd === "") {
        pwdError.textContent = "비밀번호를 입력하세요";
    } else if (!/^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,20}$/.test(pwd)) {
        pwdError.textContent = "비밀번호는 8~20자이며 대소문자, 숫자, 특수문자를 포함해야 합니다.";
    } else {
        pwdError.textContent = "";
    }
}

// 이름 유효성 검사
function checkName(input) {
    const name = input.value;
    const nameError = document.getElementById('name-error');
    if (name === "") {
        nameError.textContent = "이름을 입력하세요";
    } else {
        nameError.textContent = "";
    }
}

// 이메일 유효성 검사
function checkEmail(input) {
    const email = input.value;
    const emailError = document.getElementById('email-error');
    if (email === "") {
        emailError.textContent = "이메일을 입력하세요";
    } else {
        // 중복 검사 (가상 AJAX 호출 예제)
        fetch(`/9999/checkEmail.do?email=${encodeURIComponent(email)}`)
            .then(response => response.json())
            .then(data => {
                if (data.exists) {
                    emailError.textContent = "중복된 이메일이 있습니다";
                    input.setCustomValidity("중복된 이메일이 있습니다");
                } else {
                    emailError.textContent = "";
                    input.setCustomValidity("");
                }
            });
    }
}

// 폼 전체 유효성 검사
function validateForm(form) {
    let isValid = true;
    let errorMessage = "";

    // 아이디 입력 검사
    if (form.id && form.id.value === "") {
        errorMessage += "아이디를 입력하세요\n";
        form.id.focus();
        isValid = false;
    }

    // 비밀번호 입력 검사
    if (form.pwd && form.pwd.value === "") {
        errorMessage += "비밀번호를 입력하세요\n";
        form.pwd.focus();
        isValid = false;
    } else if (!/^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,20}$/.test(form.pwd.value)) {
        errorMessage += "비밀번호는 8~20자이며 대소문자, 숫자, 특수문자를 포함해야 합니다.\n";
        form.pwd.focus();
        isValid = false;
    }

    // 이름 입력 검사
    if (form.name && form.name.value === "") {
        errorMessage += "이름을 입력하세요\n";
        form.name.focus();
        isValid = false;
    }

    // 이메일 입력 검사
    if (form.email && form.email.value === "") {
        errorMessage += "이메일을 입력하세요\n";
        form.email.focus();
        isValid = false;
    }

    // 오류 메시지 출력
    if (!isValid) {
        alert(errorMessage.trim());
    }

    return isValid;
}
