#Requires AutoHotkey v2.0

; ====================================
; ime.ahk - IME制御ユーティリティ
; ====================================
; Windows IME のON/OFF切り替え機能を提供します。

; ====================================
; toggleIME 関数
; ====================================
; IME の状態を切り替えます。
; オン → オフ、オフ → オン
toggleIME() {
    ; IME の現在の状態を取得
    currentIMEState := GetIMEState()
    
    if (currentIMEState = 1) {
        ; IME がオンの場合、オフにする
        SetIMEState(0)
        log("IME をオフにしました")
    } else {
        ; IME がオフの場合、オンにする
        SetIMEState(1)
        log("IME をオンにしました")
    }
}

; ====================================
; setIMEOn 関数
; ====================================
; IME を明示的にオンにします。
setIMEOn() {
    currentIMEState := GetIMEState()
    if (currentIMEState != 1) {
        SetIMEState(1)
        log("IME をオンにしました")
    }
}

; ====================================
; setIMEOff 関数
; ====================================
; IME を明示的にオフにします。
setIMEOff() {
    currentIMEState := GetIMEState()
    if (currentIMEState != 0) {
        SetIMEState(0)
        log("IME をオフにしました")
    }
}

; ====================================
; GetIMEState 関数（内部用）
; ====================================
; IME の現在の状態を取得します。
; 戻り値: 1 = オン、0 = オフ
GetIMEState() {
    ; WinGetIMEMode を使用して IME の状態を取得
    imeMode := WinGetIMEMode("A")
    
    ; IME モードが 0x0000 の場合はオフ、それ以外はオンと判定
    return (imeMode != 0x0000) ? 1 : 0
}

; ====================================
; SetIMEState 関数（内部用）
; ====================================
; IME の状態を設定します。
; state: 1 = オン、0 = オフ
SetIMEState(state) {
    ; 現在のアクティブウィンドウを取得
    hwnd := WinGetID("A")
    
    ; IME をコントロールするためのIUnknown インターフェース
    ; PostMessage を使用して WM_IME_CONTROL メッセージを送信
    
    if (state = 1) {
        ; IME をオンにする（日本語入力モード）
        PostMessage(0x0283, 0x0006, 0x0001, , "A")  ; WM_IME_CONTROL, IMC_SETOPENSTATUS
    } else {
        ; IME をオフにする（英数字モード）
        PostMessage(0x0283, 0x0006, 0x0000, , "A")  ; WM_IME_CONTROL, IMC_SETOPENSTATUS
    }
    
    Sleep(50)  ; IME の状態変更が反映されるまで少し待つ
}
