#Requires AutoHotkey v2.0

; ====================================
; log.ahk - ロギングユーティリティ
; ====================================
; シンプルなログ出力機能を提供します。
; デバッグ時には OutputDebug でデバッガに出力し、
; 必要に応じてファイル出力やユーザー通知も行えます。

; ====================================
; log 関数
; ====================================
; メッセージをログ出力します。
; 
; @param message ログメッセージ（文字列）
; @param level ログレベル（"info", "warning", "error"）デフォルトは "info"
; @param showMessageBox エラー時にユーザーに通知するか（true/false）デフォルトは false
log(message, level := "info", showMessageBox := false) {
    ; タイムスタンプの生成
    timestamp := FormatTime(A_Now, "yyyy-MM-dd HH:mm:ss")
    
    ; レベルに応じたプレフィックス
    levelPrefix := ""
    switch level {
        case "info":
            levelPrefix := "[INFO]"
        case "warning":
            levelPrefix := "[WARNING]"
        case "error":
            levelPrefix := "[ERROR]"
        default:
            levelPrefix := "[INFO]"
    }
    
    ; ログメッセージの組み立て
    logMessage := timestamp . " " . levelPrefix . " " . message
    
    ; OutputDebug でデバッガに出力（DbgView などで確認可能）
    OutputDebug(logMessage)
    
    ; エラーレベルで、かつ通知が有効な場合はユーザーに表示
    if (level = "error" && showMessageBox) {
        MsgBox(message, "エラー", "IconX")
    }
}

; ====================================
; logError 関数（便利関数）
; ====================================
; エラーログを出力し、オプションでユーザーに通知します。
; 
; @param message エラーメッセージ
; @param showMessageBox ユーザーに通知するか（デフォルトは true）
logError(message, showMessageBox := true) {
    log(message, "error", showMessageBox)
}

; ====================================
; logWarning 関数（便利関数）
; ====================================
; 警告ログを出力します。
; 
; @param message 警告メッセージ
logWarning(message) {
    log(message, "warning", false)
}
