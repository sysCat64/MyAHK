#Requires AutoHotkey v2.0

; ====================================
; window.ahk - ウィンドウ操作ユーティリティ
; ====================================

; アクティブウィンドウをデスクトップ中央に移動させる
centerWindowOnDesktop() {
    ; アクティブウィンドウを取得
    activeWin := WinGetID("A")
    
    ; ウィンドウが存在するか確認
    if (!activeWin) {
        log("アクティブウィンドウが見つかりません")
        return false
    }
    
    ; ウィンドウの現在のサイズと位置を取得
    WinGetPos(&winX, &winY, &winWidth, &winHeight, activeWin)
    
    ; プライマリスクリーン（デスクトップ）のサイズを取得
    ; モニター1のサイズを使用（複数モニター環境対応）
    monitorLeft := 0
    monitorTop := 0
    monitorRight := A_ScreenWidth
    monitorBottom := A_ScreenHeight
    
    ; デスクトップの中央座標を計算
    screenWidth := monitorRight - monitorLeft
    screenHeight := monitorBottom - monitorTop
    centerX := monitorLeft + (screenWidth - winWidth) // 2
    centerY := monitorTop + (screenHeight - winHeight) // 2
    
    ; 計算結果をログ出力
    log(Format("ウィンドウ移動: 中央座標=({}, {})", centerX, centerY))
    
    ; ウィンドウを中央に移動
    WinMove(centerX, centerY, winWidth, winHeight, activeWin)
    
    return true
}
