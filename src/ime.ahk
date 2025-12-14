#Requires AutoHotkey v2.0

; ロギングユーティリティ
#Include lib\log.ahk

; ====================================
; ime.ahk - IME制御ユーティリティ
; ====================================
; Windows IME のON/OFF切り替え機能を提供します。
; Windows API を呼び出して IME を制御します。

; ====================================
; toggleIME 関数
; ====================================
; IME の状態を切り替えます。
; 全角/半角キー（vkF3/vkF4）を送信してIMEをトグルします。
toggleIME() {
    try {
        ; 全角/半角キーを送信（vkF3sc029）
        ; vkF3 = 全角/半角キーの仮想キーコード
        ; sc029 = スキャンコード
        Send("{vkF3sc029}")
        log("IME を切り替えました")
    } catch as err {
        logError("IME 切り替え処理に失敗しました: " . err.What, false)
    }
}

; ====================================
; setIMEOn 関数
; ====================================
; IME を明示的にオンにします。
; 現在の状態を確認し、オフの場合のみトグルします。
setIMEOn() {
    try {
        ; 現在のIME状態を取得
        currentState := GetIMEState()
        
        if (currentState = 0) {
            ; IME がオフの場合のみトグル
            Send("{vkF3sc029}")
            log("IME をオンにしました")
        } else {
            log("IME は既にオンです")
        }
    } catch as err {
        logError("IME のオン処理に失敗しました: " . err.What, false)
    }
}

; ====================================
; setIMEOff 関数
; ====================================
; IME を明示的にオフにします。
; 無変換キーを送信して、状態に関わらず確実にオフにします。
setIMEOff() {
    try {
        ; 無変換キー（vk1Dsc07B）を送信してIMEを確実にオフ
        ; 無変換キーはトグルではなく、常にIMEをオフにする
        Send("{vk1Dsc07B}")
        log("IME をオフにしました")
    } catch as err {
        logError("IME のオフ処理に失敗しました: " . err.What, false)
    }
}

; ====================================
; GetIMEState 関数（内部用）
; ====================================
; IME の現在の状態を取得します。
; 戻り値: 1 = オン、0 = オフ、-1 = 取得失敗
GetIMEState() {
    try {
        hwnd := WinGetID("A")
        
        ; ImmGetContext でIMEコンテキストを取得
        hIMC := DllCall("imm32\ImmGetContext", "Ptr", hwnd, "Ptr")
        
        if (hIMC) {
            ; ImmGetOpenStatus でIMEの状態を取得
            state := DllCall("imm32\ImmGetOpenStatus", "Ptr", hIMC, "Int")
            
            ; IMEコンテキストを解放
            DllCall("imm32\ImmReleaseContext", "Ptr", hwnd, "Ptr", hIMC)
            
            return state
        } else {
            return -1  ; 取得失敗
        }
    } catch {
        return -1  ; エラー時は取得失敗
    }
}
