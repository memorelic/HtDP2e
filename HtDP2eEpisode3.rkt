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

;;QUestion 39
;;车辆与世界的定义
(define WIDTH-OF-WORLD 200)
(define WHEEL-RADIUS 5)

(define WHEEL-DISTANCE (* WHEEL-RADIUS 2))
(define CAR-LENGTH (* WHEEL-RADIUS 8))
(define CAR-MID-LENGTH (* WHEEL-RADIUS 5))
(define CAR-FRONT-HEIGHT (* 2 WHEEL-RADIUS))
(define CAR-MID-HEIGHT (* 1.5 WHEEL-RADIUS))

(define WHEEL (circle WHEEL-RADIUS "solid" "black"))
(define SPACE (rectangle WHEEL-DISTANCE (* 2 WHEEL-RADIUS) "solid" "white"))
(define BOTH-WHEELS (beside WHEEL SPACE WHEEL))
(define CARBOTTOM (rectangle CAR-LENGTH CAR-FRONT-HEIGHT "solid" "red"))
(define CARTOP (rectangle CAR-MID-LENGTH CAR-MID-HEIGHT "solid" "red"))
(define CAR (overlay/offset (above CARTOP CARBOTTOM) 0 (* WHEEL-RADIUS 2) BOTH-WHEELS))
;;WorldState表示当前程序状态
;;WorldState -> image
;;big-bang使用此函数将当前状态转换为图像
