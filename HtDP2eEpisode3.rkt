;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname HtDP2eEpisode3) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(require 2htdp/image)
(require 2htdp/universe)

;;Question 34
;;character是string的组成元素
;;string -> character
;;提取string的首字母
;;输入"myname"获得"m"
(define (string-first string)
  (string-ith string 0))

;;Question 35
;;string -> character
;;提取string的最后一个字母
;;输入"myname"获得"e"
(define (string-last string)
  (string-ith string (- (string-length string) 1)))

;;Question 36
;;image -> number
;;获取一个图像的像素数量
;;输入图像...
(define (image-area imag)
  (* (image-width imag) (image-height imag)))

;;Question 37
;;string -> string
;;获得给定字符串移除首字母后的字符串
;;输入"myname"获取"yname"
(define (string-reset string)
  (substring string 1))

;;Question 38
;;string -> string
;;获得给定字符串移除最后一个字符的字符串
;;输入"myname"获得"mynam"
(define (string-remove-last string)
  (substring string 0 ( - (string-length string) 1)))

;;QUestion 39 40 41
;;车辆与世界的定义
(define WIDTH-OF-WORLD 400)
(define HEIGHT-OF-WORLD 100)
;;单一控制点->轮半径
(define WHEEL-RADIUS 5)

(define WHEEL-DISTANCE (* WHEEL-RADIUS 2))
(define CAR-LENGTH (* WHEEL-RADIUS 8))
(define CAR-MID-LENGTH (* WHEEL-RADIUS 4))
(define CAR-FRONT-HEIGHT (* 2 WHEEL-RADIUS))
(define CAR-MID-HEIGHT (* 1.5 WHEEL-RADIUS))



(define WHEEL (circle WHEEL-RADIUS "solid" "black"))
(define SPACE (rectangle WHEEL-DISTANCE (* 2 WHEEL-RADIUS) "solid" "white"))
(define BOTH-WHEELS (beside WHEEL SPACE WHEEL))
(define CARBOTTOM (rectangle CAR-LENGTH CAR-FRONT-HEIGHT "solid" "red"))
(define CARTOP (rectangle CAR-MID-LENGTH CAR-MID-HEIGHT "solid" "red"))
;;(define CAR2 (overlay/offset (above CARTOP CARBOTTOM) 0 (* WHEEL-RADIUS 2) BOTH-WHEELS))
(define CAR (overlay/offset (above CARTOP CARBOTTOM) 0 (* WHEEL-RADIUS 1.75)  BOTH-WHEELS))
(define BACKGROUND (empty-scene WIDTH-OF-WORLD HEIGHT-OF-WORLD))
(define Y-CAR (- HEIGHT-OF-WORLD (/ (image-height CAR) 2)))

;;WorldState表示当前程序状态
;;WorldState是左边距与车之间的距离

;;WorldState -> WorldState
;;时钟每次变化，big-bang调用此函数进行状态变换
;;input 40 -> output 43
(define (tock ws)
  (+ ws 1))
;;Question 40
;;(check-expect (tock 20) 23)
;;(check-expect (tock 40) 43)
;;(check-expect (tock 41) 44)

;;WorldState -> image
;;big-bang使用此函数将当前状态转换为图像
;;按照给定的状态将CAR放入BACKGROUND
(define (render ws)
  (place-image CAR (- WIDTH-OF-WORLD ws) Y-CAR BACKGROUND))


(define tree
  (underlay/xy (circle 10 "solid" "green")
               9 15
               (rectangle 2 20 "solid" "brown")))

(define BACKGROUND-WITH-TREE
  (place-image tree
               200
               (- HEIGHT-OF-WORLD (/ (image-height tree) 2))
               (empty-scene WIDTH-OF-WORLD HEIGHT-OF-WORLD)))

(define (end? ws)
  (< (+ (/ CAR-LENGTH 2) WIDTH-OF-WORLD) ws))

(define (render2 ws)
  (place-image CAR ws Y-CAR BACKGROUND-WITH-TREE))

(define (main ws)
  (big-bang ws
    [on-tick tock]
    [to-draw render2]
    [stop-when end?]))
;;Question 42
;;只需要把render中的 ws 替换为 (- WIDTH-OF-WORLD ws)即可实现

(define (render3 ws)
  (place-image CAR ws ( + (- Y-CAR 10) (* (sin ws) 5)) BACKGROUND))

;;Question 43
;;这个程序中的render依据tock得出的WorldState运行
;;animate函数直接根据时钟运行
;;更改render使得render中的y坐标根据(sin ws)改变即可，适当乘以比例系数使效果更明显，注意将车稍微上抬一点
(define (main2 ws)
  (big-bang ws
    [on-tick tock]
    [to-draw render3]
    [stop-when end?]))

;;Question 44
;;WorldState Number Number String -> WOrldState
;;如果给定"button-down"，将车放到x-mouse位置
(define (hyper-transmission x-position-of-car x-mouse y-mouse me)
  (cond
  [(string=? "button-down" me) x-mouse]
  [else x-position-of-car]))

(define (main3 ws)
  (big-bang ws
    [on-tick tock]
    [to-draw render2]
    [on-mouse hyper-transmission]
    [stop-when end?]))