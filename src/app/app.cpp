#include "app.h"

#include "module/feature.h"

namespace App {

App::App() : m_feature(Module::Feature::create()) {}

/**
 * @brief Example doxygen comment.
 *
 * @return int
 */
int App::run() { return m_feature->run(2, 3); }

} // namespace App
