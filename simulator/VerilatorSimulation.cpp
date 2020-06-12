#include "VerilatorSimulation.hpp"

void VerilatorSimulation::preload_cpu_program(const std::vector<uint8_t> &program) {
    auto cpu_ram0 = tb->ics32_tb__DOT__ics32__DOT__cpu_ram__DOT__cpu_ram_0__DOT__mem;
    auto cpu_ram1 = tb->ics32_tb__DOT__ics32__DOT__cpu_ram__DOT__cpu_ram_1__DOT__mem;

    size_t ipl_load_length = std::min((size_t)0x20000, program.size());
    for (size_t i = 0; i < ipl_load_length / 4; i++) {
        cpu_ram0[i] = program[i * 4] | program[i * 4 + 1] << 8;
        cpu_ram1[i] = program[i * 4 + 2] | program[i * 4 + 3] << 8;
    }

    const size_t flash_user_base = 0x100000;
    auto flash = tb->ics32_tb__DOT__sim_flash__DOT__memory;

    std::copy(program.begin(), program.end(), &flash[flash_user_base]);
}
