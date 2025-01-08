#include <GL/glew.h>
#include <GLFW/glfw3.h>
#include <stdio.h>

int main() {
  if (!glfwInit()) {
    printf("error: glfwInit failed");
  }

  if (!glewInit()) {
    printf("error: glewInit failed");
  }

  GLFWwindow *window =
      glfwCreateWindow(640, 480, "My cool little example", NULL, NULL);
  if (!window) {
    printf("error: glfwCreateWindow failed");
  }

  glfwMakeContextCurrent(window);
  while (!glfwWindowShouldClose(window)) {
    glfwSwapBuffers(window);
    glfwPollEvents();
  }
  glfwDestroyWindow(window);
  glfwTerminate();
}
