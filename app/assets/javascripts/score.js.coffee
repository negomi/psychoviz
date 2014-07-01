# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

window.Score =
  init: ->
    @e = 0
    @i = 10
    @s = 0
    @n = 20
    @t = 0
    @f = 20
    @j = 0
    @p = 20
    @chartSettings =
      labels : ["E","I","S","N","T","F","J","P"],
      datasets : [
        fillColor : "rgba(220,220,220,0.5)",
        strokeColor : "rgba(220,220,220,1)",
        pointColor : "rgba(220,220,220,1)",
        pointStrokeColor : "#fff",
        data : [gon.e, gon.i, gon.s, gon.n, gon.t, gon.f, gon.j, gon.p]
      ]

  e_i: [1, 8, 15, 22, 29, 36, 43, 50, 57, 64]
  s_n: [2, 3, 9, 10, 16, 17, 23, 24, 30, 31, 37, 38, 44, 45, 51, 52, 58, 59, 65, 66]
  t_f: [4, 5, 11, 12, 18, 19, 25, 26, 32, 33, 39, 40, 46, 47, 53, 54, 60, 61, 67, 68]
  j_p: [6, 7, 13, 14, 20, 21, 27, 28, 34, 35, 41, 42, 48, 49, 55, 56, 62, 63, 69, 70]

  runningScore: (q, answer_a) ->
    if q in @e_i and answer_a is true
      @e += 1
      @i -= 1
    else if q in @s_n and answer_a is true
      @s += 1
      @n -= 1
    else if q in @t_f and answer_a is true
      @t += 1
      @f -= 1
    else if q in @j_p and answer_a is true
      @j += 1
      @p -= 1

  personalityType: (score) ->
    [gon.e, gon.i, gon.s, gon.n, gon.t, gon.f, gon.j, gon.p] = [score.e, score.i, score.s, score.n, score.t, score.f, score.j, score.p]
    type = []
    if score.e>score.i then type.push("E") else type.push("I")
    if score.s>score.n then type.push("S") else type.push("N")
    if score.t>score.f then type.push("T") else type.push("F")
    if score.j>score.p then type.push("J") else type.push("P")
    gon.personalityType = type
    return type

  setChart: (chartData)->
    # Calling this again in case the window resized
    Friend.calculateLayout()
    ctx = document.getElementById("myChart").getContext("2d")
    myChart = new Chart(ctx).Radar(chartData)
