package com.viewpharm.yakal.main.model

data class PillTodo(
    val id: Int,
    val name: String,
    val effect: String,
    val kdCode: String,
    val atcCode: AtcCode,
    val count: Int,
    val isOverLap: Boolean,
    val isTaken: Boolean
) {
    override fun toString(): String {
        // 각 변수별로 line마다 출력
        return "PillTodo(id=$id,\n" +
                "name='$name',\n" +
                "effect='$effect',\n" +
                "kdCode='$kdCode',\n" +
                "atcCode=$atcCode,\n" +
                "count=$count,\n" +
                "isOverLap=$isOverLap,\n" +
                "isTaken=$isTaken)\n"
    }
}