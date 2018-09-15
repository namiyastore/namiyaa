window.profile = {
    profileInfo : null,
    message : null,
    url : null,
    currentState : null,
    isIeLessThan9 : false,
    isIe10 : false,
    isIe11 : false,
    profileImageSizeType : "s160",
    isFileChooserCancelDeleteEvent : false,
    firefoxKeyEventInterval : 0,
    isClickedConfirmBtn : false,

    init : function(profileInfo, message, url) {
        this.profileInfo = profileInfo;
        this.message = message;
        this.url = url;
        this.isIeLessThan9 = this._isIeLessThan9();
        this.isIe10 = this._isIe10();
        this.isIe11 = this._isIe11();
        this.isClickedConfirmBtn = false;
    },

    dom : {
        $btnChangeProfile : null,
        $btnDelete : null,
        $btnCancel : null,
        $btnConfirm : null,
        $imgThumb : null,
        $inpNickname : null,
        $form : null,
        $inputImage : null,
        $deleteYn : null
    },

    state : {
        notChanged : {
            run : function(self) {
                self.profileInfo.imageUrl = self.profileInfo.originImageUrl;
                this._setDisability(self);
                self._setThumbNail();
            },

            change : function(event, self) {
                if (event === "delete") {
                    self.state.deleting._setFromNotChanged();
                    self.currentState = self.state.deleting;
                    self.currentState.run(self);
                }

                if (event === "changing") {
                    self.state.changing._setFromNotChanged();
                    self.currentState = self.state.changing;
                    self.currentState.run(self);
                }

                if(event === "changing_avatar") {
                    self.state.changing_avatar._setFromNotChanged();
                    self.currentState = self.state.changing_avatar;
                    self.currentState.run(self);
                }
            },

            _setDisability : function(self) {
                self._setColorBtnDisabled(self.dom.$btnConfirm);
                self._setBtnConfirmDisability(self);

                if (self.profileInfo.originImageUrl === "") {
                    self._setDisabled(self.dom.$btnDelete);
                } else {
                    self._setEnabled(self.dom.$btnDelete);
                }
            },
        },

        deleting : {
            isFromChanged : false,
            isFromDeleted : false,
            isFromNotChanged : false,

            run : function(self) {
                if (this.isFromNotChanged) {
                    if (self.isFileChooserCancelDeleteEvent) {
                        self.isFileChooserCancelDeleteEvent = false;
                        self.currentState = self.state.notChanged;
                        self.currentState.run();

                        return;
                    }

                    if (!self.isFileChooserCancelDeleteEvent && self._hasOriginImage(self)) {
                        self.isFileChooserCancelDeleteEvent = false;

                        self._deleteTmpSavedImage(self, function() {
                            self._clearFileChooser(self);
                            self.currentState = self.state.deleted;
                            self.currentState.run(self);
                        });

                        return;
                    }

                    return;
                }

                if (this.isFromChanged) {
                    self.isFileChooserCancelDeleteEvent = false;

                    self._deleteTmpSavedImage(self, function() {
                        self._clearFileChooser(self);
                        self.currentState = self.state.deleted;
                        self.currentState.run(self);
                    });

                    return;
                }

                if (this.isFromDeleted) {
                    self.isFileChooserCancelDeleteEvent = false;

                    self._deleteTmpSavedImage(self, function() {
                        self._clearFileChooser(self);
                        self.currentState = self.state.deleted;
                        self.currentState.run(self);
                    });

                    return;
                }

                return;
            },

            change : function(event, self) {
                // NTD
            },

            _setDisability : function(self) {
                self._setDisabled(self.dom.$btnConfirm);
                self._setDisabled(self.dom.$btnDelete);
            },

            _setFromChanged : function() {
                this.isFromChanged = true;
                this.isFromDeleted = false;
                this.isFromNotChanged = false;
            },

            _setFromDeleted : function() {
                this.isFromChanged = false;
                this.isFromDeleted = true;
                this.isFromNotChanged = false;
            },

            _setFromNotChanged : function() {
                this.isFromChanged = false;
                this.isFromDeleted = false;
                this.isFromNotChanged = true;
            }
        },

        changing : {
            isFromChanged : false,
            isFromDeleted : false,
            isFromNotChanged : false,

            run : function(self) {
                var beforeState;

                if (self.isFileChooserCancelDeleteEvent) {
                    if (this.isFromChanged) {
                        self.state.deleting._setFromChanged();
                    }

                    if (this.isFromDeleted) {
                        self.state.deleting._setFromDeleted();
                    }

                    if (this.isFromNotChanged) {
                        self.state.deleting._setFromNotChanged();
                    }

                    self.currentState = self.state.deleting;
                    self.currentState.run(self);
                    return;
                }

                beforeState = this._getBeforeState(self);
                self.profileInfo.deleteYn = "";
                self._checkImageAndTmpSave(self, beforeState, this.successCallback, this.failCallback, this.errorCallback);
            },

            successCallback : function(data, self) {
                var imageUrl;

                imageUrl = (data.split("|"))[2];
                self.profileInfo.imageUrl = imageUrl;
                self.currentState = self.state.changed;
                self.currentState.run(self);
            },

            failCallback : function(result, self, beforeState) {
                var unauthErr = "401";

                if (result.code === unauthErr) {
                    self._alertOverTimeErrAndGoToReturnUrl(self);
                    return;
                }

                if ($.isNumeric(result.code)) {
                    alert(result.message);
                } else {
                    /*
                        IE8, 9에서는 apache의 max content size error가 html문서로 내려온다.
                        Max Size Upload 에러로 유추할 수 있으나, 10메가 이상의 파일을 올리는 경우가 드물 것이므로
                        일시적인 에러로 처리한다
                     */
                    alert(self.message.temporaryAccessErrMessage);
                }
                self._clearFileChooser(self);

                self.currentState = beforeState;
                self.currentState.run(self);
            },

            errorCallback : function(self, beforeState) {
                alert(self.message.temporaryAccessErrMessage);

                self._clearFileChooser(self);

                self.currentState = beforeState;
                self.currentState.run(self);
            },

            change : function(event, self) {
                // NTD
            },

            _setDisability : function(self) {
                self._setDisabled(self.dom.$btnConfirm);
                self._setDisabled(self.dom.$btnDelete);
            },

            _setFromChanged : function() {
                this.isFromChanged = true;
                this.isFromDeleted = false;
                this.isFromNotChanged = false;
            },

            _setFromDeleted : function() {
                this.isFromChanged = false;
                this.isFromDeleted = true;
                this.isFromNotChanged = false;
            },

            _setFromNotChanged : function() {
                this.isFromChanged = false;
                this.isFromDeleted = false;
                this.isFromNotChanged = true;
            },

            _getBeforeState : function(self) {
                if (this.isFromChanged) {
                    return self.state.changed;
                }

                if (this.isFromDeleted) {
                    return self.state.deleted;
                }

                if (this.isFromNotChanged) {
                    return self.state.notChanged;
                }
            }
        },

        changing_avatar : {
            isFromChanged : false,
            isFromDeleted : false,
            isFromNotChanged : false,

            run : function(self) {
                var beforeState;

                if (self.isFileChooserCancelDeleteEvent) {
                    if (this.isFromChanged) {
                        self.state.deleting._setFromChanged();
                    }

                    if (this.isFromDeleted) {
                        self.state.deleting._setFromDeleted();
                    }

                    if (this.isFromNotChanged) {
                        self.state.deleting._setFromNotChanged();
                    }

                    self.currentState = self.state.deleting;
                    self.currentState.run(self);
                    return;
                }

                beforeState = this._getBeforeState(self);
                self.profileInfo.deleteYn = "";
                self.currentState = self.state.changed;
                self.currentState.run(self);
            },

            change : function(event, self) {
                // NTD
            },

            _setDisability : function(self) {
                self._setDisabled(self.dom.$btnConfirm);
                self._setDisabled(self.dom.$btnDelete);
            },

            _setFromChanged : function() {
                this.isFromChanged = true;
                this.isFromDeleted = false;
                this.isFromNotChanged = false;
            },

            _setFromDeleted : function() {
                this.isFromChanged = false;
                this.isFromDeleted = true;
                this.isFromNotChanged = false;
            },

            _setFromNotChanged : function() {
                this.isFromChanged = false;
                this.isFromDeleted = false;
                this.isFromNotChanged = true;
            },

            _getBeforeState : function(self) {
                if (this.isFromChanged) {
                    return self.state.changed;
                }

                if (this.isFromDeleted) {
                    return self.state.deleted;
                }

                if (this.isFromNotChanged) {
                    return self.state.notChanged;
                }
            }
        },

        deleted : {
            run : function(self) {
                self.profileInfo.originImageUrl = "";
                self.profileInfo.imageUrl = "";
                self.profileInfo.deleteYn = "Y";
                this._setDisability(self);
                self._setThumbNail();
            },

            change : function(event, self) {
                if (event === "changing") {
                    self.state.changing._setFromDeleted();
                    self.currentState = self.state.changing;
                    self.currentState.run(self);
                }

                if (event === "changing_avatar") {
                    self.state.changing._setFromDeleted();
                    self.currentState = self.state.changing_avatar;
                    self.currentState.run(self);
                }
            },

            _setDisability : function(self) {
                self._setDisabled(self.dom.$btnDelete);
                self._setColorBtnEnabled(self.dom.$btnConfirm);
                self._setBtnConfirmDisability(self);
            }
        },

        changed : {
            run : function(self) {
                this._setDisability(self);
                self._setThumbNail();
            },

            change : function(event, self) {
                if (event === "delete") {
                    self.state.deleting._setFromChanged();
                    self.currentState = self.state.deleting;
                    self.currentState.run(self);
                }

                if (event === "changing") {
                    self.state.changing._setFromChanged();
                    self.currentState = self.state.changing;
                    self.currentState.run(self);
                }
            },

            _setDisability : function(self) {
                self._setEnabled(self.dom.$btnDelete);
                self._setColorBtnEnabled(self.dom.$btnConfirm);
                self._setBtnConfirmDisability(self);
            }
        }
    },

    run : function() {
        this._cacheDom();
        this._attachEvent();

        this.currentState = this.state.notChanged;
        this.currentState.run(this);
    },

    _cacheDom : function() {
        this.dom.$btnChangeProfile = $("#btnChangeProfile");
        this.dom.$btnDelete = $("#btnDelete");
        this.dom.$btnCancel = $("#btnCancel");
        this.dom.$btnConfirm = $("#btnConfirm");
        this.dom.$imgThumb = $("#imgThumb");
        this.dom.$inpNickname = $("#inpNickname");
        this.dom.$form = $("#profileForm");
        this.dom.$inputImage = $("#inputImage");
        this.dom.$deleteYn = $("#deleteYn");
        this.dom.$btnAvatar = $("#btnAvatar");
    },

    _setDisabled : function($btn) {
        $btn.addClass("btn_disable");
    },

    _setEnabled : function($btn) {
        $btn.removeClass("btn_disable");
    },

    _setColorBtnEnabled : function($btn) {
        $btn.removeClass("btn2 txt_disable");
        $btn.addClass("btn8");
    },

    _setColorBtnDisabled : function($btn) {
        $btn.removeClass("btn8");
        $btn.addClass("btn2 txt_disable");
    },

    _setBtnConfirmDisability : function(self) {
        if (self.profileInfo.isNicknameChanged) {
            self._setColorBtnEnabled(self.dom.$btnConfirm);
        }
    },

    _attachEvent : function() {
        this.dom.$btnCancel.on("click", $.proxy(this._cancelClickEvent, this));
        this.dom.$btnAvatar.on("click", $.proxy(this._avatarClickEvent, this));
        this.dom.$btnDelete.on("click", $.proxy(this._deleteClickEvent, this));
        this.dom.$btnConfirm.on("click", $.proxy(this._confirmClickEvent, this));
        this._attachKeydownEvent();
        this.dom.$inputImage.on("change", $.proxy(this._imageInputEvent, this));
    },

    _nicknameInputEvent : function() {
        this.profileInfo.nickname = this.dom.$inpNickname.val();

        if (this.profileInfo.nickname === this.profileInfo.originNickname) {
            this.profileInfo.isNicknameChanged = false;
        } else {
            this.profileInfo.isNicknameChanged = true;
        }

        this._setBtnConfirmDisability(this);
    },

    _attachKeydownEvent : function() {
        if (this._isFirefox() || this._isChrome()) {
            this._attachFirefoxKeyEvent();
        } else {
            this.dom.$inpNickname.on("keydown change", $.proxy(this._nicknameInputEvent, this));
        }
    },

    _attachFirefoxKeyEvent : function() {
        this.dom.$inpNickname.on("focus", $.proxy(function() {
            this.firefoxKeyEventInterval = setInterval($.proxy(function () {
                this.profile._nicknameInputEvent();
            }), this, 200);
        }, this));

        this.dom.$inpNickname.on("blur", $.proxy(function() {
            if (this.firefoxKeyEventInterval) {
                clearInterval(this.firefoxKeyEventInterval);
            }
        }, this));
    },

    _checkImageAndTmpSave : function(self, beforeState, successCallback, failCallback, errorCallback) {
        $("#profileForm").ajaxSubmit({
            url : self.url.checkImageAndSaveTmep,
            cache : false,
            type : "POST",
            beforeSend : function() {
                self._setDisabled(self.dom.$btnDelete);
                self._setColorBtnDisabled(self.dom.$btnConfirm);
            },
            success : function(data) {
                var result;

                result = self._parseResponse(data);
                if (result.code == 200) {
                    successCallback(data, self);
                } else {
                    failCallback(result, self, beforeState);
                }
            },
            error : function() {
                errorCallback(self, beforeState);
            }
        });
    },

    _parseResponse : function(data) {
        var result, dataArr;

        result = {};
        dataArr = data.split("|");
        result.code = dataArr[0];
        result.message = dataArr[1];

        return result;
    },

    _hasOriginImage : function(self) {
        if (self.profileInfo.originImageUrl !== "") {
            return true;
        }

        return false;
    },

    _imageInputEvent : function(event) {
        if (this._isInValidImageSize()) {
            alert(this.message.maxUploadSizeErrMessage);
            this._clearFileChooser(this);
            return;
        }

        if (event.target.value === "") {
            this.isFileChooserCancelDeleteEvent = true;
        }

        this.currentState.change("changing", this);
    },

    _isInValidImageSize : function() {
        var $file, maximumSize;

        maximumSize = 10485760;

        // File 객체가 없어 사이즈를 알아낼 수 없음
        if (!window.File) {
            return false;
        }

        $file = $("#inputImage").prop("files")[0];
        if ($file.size > maximumSize) {
            return true;
        } else {
            return false;
        }
    },

    _deleteClickEvent : function() {
        var event = "delete";

        if (this.dom.$btnDelete.hasClass("btn_disable")) {
            return;
        }

        this.currentState.change(event, this);
    },

    _confirmClickEvent : function() {
        var self = this;

        if (this.dom.$btnConfirm.hasClass("txt_disable")) {
            return;
        }

        if (!confirm(self.message.confirm)) {
            return;
        }

        this.dom.$deleteYn.val(this.profileInfo.deleteYn);

        this.isClickedConfirmBtn = true;

        $.ajax({
            url : this.url.changeProfile,
            type : "POST",
            data : self.dom.$form.serialize(),
            success : function(data) {
                var result;

                result = self._parseResponse(data);

                if (result.code === "200") {
                    location.href = Base64.decode(self.url.returnUrl);
                    return;
                }

                if (result.code === "401") {
                    self._alertOverTimeErrAndGoToReturnUrl(self);
                } else {
                    alert(result.message);
                    this.isClickedConfirmBtn = false;
                }
            },
            error : function() {
                self._alertTempErrAndGoToReturnUrl(self);
            }
        });
    },

    _cancelClickEvent : function() {
        location.href = Base64.decode(this.url.returnUrl);
    },

    _avatarClickEvent : function() {
        showAvatarWindow();
    },

    _setThumbNail : function() {
        var imageUrl = this.profileInfo.defaultImageUrl;

        if (this.profileInfo.imageUrl !== "") {
            imageUrl = this.profileInfo.imageUrl;
        } else {
            if (this.profileInfo.originImageUrl !== "") {
                imageUrl = this.profileInfo.originImageUrl;
            } else {
                imageUrl = this.profileInfo.defaultImageUrl;
            }
        }

        this.dom.$imgThumb.attr("src", imageUrl + "?type=" + this.profileImageSizeType);
    },

    _deleteTmpSavedImage : function(self, successCallback) {
        $.ajax({
            type : "POST",
            url : self.url.removeTempImageUrl,
            data : "token_help=" + self.profileInfo.token,
            success : successCallback,
            error : function() {
                self._alertTempErrAndGoToReturnUrl(self);
            }
        });
    },

    _getIeVersion : function() {
        var word;
        var version = "N/A";

        var agent = navigator.userAgent.toLowerCase();
        var name = navigator.appName;

        // IE old version ( IE 10 or Lower )
        if (name === "Microsoft Internet Explorer") {
            word = "msie ";
        } else {
            if (agent.search("trident") > -1) {
                word = "trident/.*rv:";
            } else if (agent.search("edge/") > -1) {
                word = "edge/";
            }
        }

        var reg = new RegExp(word + "([0-9]{1,})(\\.{0,}[0-9]{0,1})");

        if (reg.exec(agent) != null) {
            version = RegExp.$1;
        }

        return version;
    },

    _isIeLessThan9 : function() {
        var version = this._getIeVersion();

        if (version === "9" || version === "8" || version === "7") {
            $("#ieLessThan9Yn").val("Y");
            return true;
        }

        return false;
    },

    _isIe10 : function() {
        var version = this._getIeVersion();

        if (version === "10") {
            return true;
        }

        return false;
    },

    _isIe11 : function() {
        var version = this._getIeVersion();

        if (version === "11") {
            return true;
        }

        return false;
    },

    _isFirefox : function() {
        var userAgent = navigator.userAgent.toLowerCase();

        if (userAgent.indexOf("firefox") != -1) {
            return true;
        }

        return false;
    },

    _isChrome : function() {
        var userAgent = navigator.userAgent.toLowerCase();

        if (userAgent.indexOf("chrome") != -1) {
            return true;
        }

        return false;
    },

    _alertOverTimeErrAndGoToReturnUrl : function(self) {
        alert(self.message.overTimeReturnErrMessage);
        location.href = Base64.decode(self.url.returnUrl);
    },

    _alertTempErrAndGoToReturnUrl : function(self) {
        alert(self.message.temporaryAccessErrMessage);
        location.href = Base64.decode(self.url.returnUrl);
    },

    _clearFileChooser : function(self) {
        var originParent, originNext, tmp, fileInput;

        fileInput = document.getElementById("inputImage");

        if (self.isIe10) {
            fileInput.type = 'radio';
            fileInput.type = 'file';
        } else if (self.isIeLessThan9 || self.isIe11) {
            originParent = fileInput.parentNode;
            originNext = fileInput.nextSibling;

            tmp = document.createElement('form');
            tmp.appendChild(fileInput);
            tmp.reset();

            originParent.insertBefore(fileInput, originNext);
        } else {
            fileInput.value = "";
            return false;
        }
    },

    setAvatarImage : function(imageUrl) {
        this.profileInfo.imageUrl = imageUrl;
        this._setThumbNail();

        this.currentState.change("changing_avatar", this);
    },

    isNotAllowedToShowExitPopup : function() {
        return this.isClickedConfirmBtn;
    }
};