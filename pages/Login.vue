<template>
  <div class="login">
    <a-card title="欢迎登录" :bordered="false" class="login-wrap">
      <a-form
        :model="formState"
        name="form"
        class="login-form"
        @submit="onSubmit"
        :form="form"
      >
        <a-form-item
          label="账号"
          name="username"
          :rules="[{ required: true, message: 'Please input your username!' }]"
        >
          <a-input v-model="formState.userName" placeholder="登录账号">
          </a-input>
        </a-form-item>
        <a-form-item
          label="密码"
          name="password"
          :rules="[{ required: true, message: 'Please input your password!' }]"
        >
          <a-input-password v-model="formState.password" placeholder="登录密码">
          </a-input-password>
        </a-form-item>

        <a-form-item>
          <a-button type="primary" style="width: 100%" htmlType="submit"
            >登录</a-button
          >
        </a-form-item>
      </a-form>
    </a-card>
  </div>
</template>

<script>
export default {
  name: "Login",
  data() {
    return {
      form: this.$form.createForm(this),
      formState: {
        userName: null,
        password: null,
      },
    };
  },
  mounted() {},
  methods: {
    onSubmit(e) {
      e.preventDefault();
      this.$message.loading("登录中...");
      this.form.validateFields((err) => {
        if (!err) {
          this.$axios
            .$get(
              "/api/user/login?account=" +
                this.formState.userName +
                "&password=" +
                this.formState.password
            )
            .then((resp) => {
              if (resp) {
                this.$auth.$storage.setLocalStorage(
                  "userInfo",
                  JSON.stringify(resp)
                );
                this.$message.destroy();
                this.$message.info("登录成功");
                this.$router.push("/");
              } else {
                this.$message.destroy();
                this.$message.error("用户名或密码错误");
              }
            });
        }
      });
    },
  },
};
</script>
<style>
html,
body {
  padding: 0;
  margin: 0;
  width: 100%;
  height: 100vh;
}

.login {
  height: 100vh;
  display: flex;
  align-items: center;
  flex: 1;
  background: rgb(250, 240, 240);
}

.login-wrap {
  width: 400px;
  height: 400px;
  margin: auto;
  border-radius: 8px;
  background: #fff;
  box-shadow: 0px 0 40px rgba(0, 0, 0, 0.3);
}
</style>